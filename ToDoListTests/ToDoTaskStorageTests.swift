//
//  ToDoTaskStorageTests.swift
//  ToDoListTests
//
//  Created by Vladislav Smelov on 10/21/24.
//

import XCTest
@testable import ToDoList

final class ToDoTaskStorageTests: XCTestCase {
    
    var storage = ToDoTaskStorage()
    var fetchedTasks: [ToDoTask] = []

    override func setUpWithError() throws {
        fetchedTasks = try storage.fetchTasks()
    }

    func testFetchTasks() throws {
        XCTAssertFalse(fetchedTasks.isEmpty)
    }

    func testAddTaskSuccess() throws {
        let taskToAdd = ToDoTask(name: "New", priority: .hight, dueDate: .now)
        try storage.add(task: taskToAdd)
        let updatedList = try storage.fetchTasks()
        XCTAssertTrue(updatedList.contains(taskToAdd))
    }

    func testAddTaskFailed() {
        do {
            let taskToAdd = ToDoTask(name: "", priority: .unknown, dueDate: .now)
            try storage.add(task: taskToAdd)
            _ = try storage.fetchTasks()
            XCTFail("Error should be thrown")
        } catch {
            XCTAssertFalse(error.localizedDescription.isEmpty)
        }
    }

    func testUpdateSuccess() throws {
        var taskToUpdate = fetchedTasks[3]
        
        XCTAssert(taskToUpdate.name != "NewName")
        taskToUpdate.name = "NewName"
        try storage.update(task: taskToUpdate)

        let updatedList = try storage.fetchTasks()
        XCTAssert(updatedList[3].name == "NewName")
    }

    func testUpdateFailed_wrongTaskData() {
        do {
            var taskToUpdate = fetchedTasks[3]
            taskToUpdate.priority = .unknown
            try storage.update(task: taskToUpdate)

            XCTFail("Error should be thrown")
        } catch {
            XCTAssertFalse(error.localizedDescription.isEmpty)
        }
    }

    func testUpdateFailed_noTaskInStorage() {
        do {
            let taskToUpdate = ToDoTask(name: "0", priority: .low, dueDate: .now)
            try storage.update(task: taskToUpdate)
            XCTFail("Error should be thrown")
        } catch {
            XCTAssertFalse(error.localizedDescription.isEmpty)
        }
    }

    func testDeleteTaskSuccess() throws {
        let taskToDelete = fetchedTasks[3]
        try storage.delete(task: taskToDelete)

        let updatedList = try storage.fetchTasks()
        XCTAssertFalse(updatedList.contains(taskToDelete))
    }

    func testDeleteTaskFailed_noTaskInStorage() {
        do {
            let taskToDelete = ToDoTask(name: "0", priority: .low, dueDate: .now)
            try storage.delete(task: taskToDelete)
            XCTFail("Error should be thrown")
        } catch {
            XCTAssertFalse(error.localizedDescription.isEmpty)
        }
    }
}
