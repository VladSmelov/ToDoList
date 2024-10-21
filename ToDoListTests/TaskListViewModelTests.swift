//
//  TaskListViewModelTests.swift
//  ToDoListTests
//
//  Created by Vladislav Smelov on 10/21/24.
//

import XCTest
@testable import ToDoList

final class TaskListViewModelTests: XCTestCase {

    var date: Date = Date(timeIntervalSince1970: 10000000)
    var mockedTaskList: [ToDoTask] {
        [
            ToDoTask(name: "First", priority: .low, dueDate: date),
            ToDoTask(name: "Second", priority: .medium, dueDate: date),
            ToDoTask(name: "Third", priority: .hight, dueDate: date),
        ]
    }
    var viewModel: TaskListViewModel = .init()
    let mockedStorage = MockedToDoTaskStorage()

    override func setUp() {
        ServiceLocator.shared = .init(storage: mockedStorage)
        mockedStorage.mockedFetchResult = mockedTaskList
    }

    func testFetchDataSuccess() {
        viewModel.fetchTasks()
        XCTAssert(viewModel.tasksToDisplay.count == mockedTaskList.count)
        XCTAssertNil(viewModel.errorText)
    }

    func testFetchDataFailed() {
        mockedStorage.mockedError = ToDoTaskStorageErrors.emptyStorage
        viewModel.fetchTasks()
        
        XCTAssert(viewModel.tasksToDisplay.isEmpty)
        XCTAssert(viewModel.errorText == ToDoTaskStorageErrors.emptyStorage.localizedDescription)
    }

    func testDeleteTaskSuccess() {
        viewModel.fetchTasks()
        viewModel.deleteTask(at: IndexSet(integer: 1))
        XCTAssertFalse(mockedTaskList[1] == mockedStorage.deletedTask)
    }

    func testDeleteTaskFailed() {
        viewModel.fetchTasks()
        mockedStorage.mockedError = ToDoTaskStorageErrors.emptyStorage
        viewModel.deleteTask(at: IndexSet(integer: 1))
        XCTAssert(viewModel.errorText == ToDoTaskStorageErrors.emptyStorage.localizedDescription)
    }
}
