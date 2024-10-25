//
//  TaskContentViewModelTest.swift
//  ToDoListTests
//
//  Created by Vladislav Smelov on 10/25/24.
//

import XCTest
@testable import ToDoList

final class TaskContentViewModelTest: XCTestCase {
    // TODO: DRY
    var date: Date = Date(timeIntervalSince1970: 10000000)
    var mockedTaskList: [ToDoTask] {
        [
            ToDoTask(name: "First", priority: .low, dueDate: date),
            ToDoTask(name: "Second", priority: .medium, dueDate: date),
            ToDoTask(name: "Third", priority: .hight, dueDate: date),
        ]
    }
    var viewModel: TaskContentViewModel!
    let mockedStorage = MockedToDoTaskStorage()

    override func setUp() {
        ServiceLocator.shared = .init(
            storage: mockedStorage,
            userPreferences: MockedUserPreferencesStorage())
        mockedStorage.mockedFetchResult = mockedTaskList
    }

    func testSwitchViewMode() {
        let taskToEdit = ToDoTask(name: "Temp", priority: .low, dueDate: date)
        viewModel = .init(viewMode: .view(task: taskToEdit))

        if case .view(_) = viewModel.viewMode {
            XCTAssert(true)
        } else {
            XCTFail()
        }

        viewModel.run(action: .edit)
        if case .edit(_) = viewModel.viewMode {
            XCTAssert(true)
        } else {
            XCTFail()
        }
    }

    func testAddTaskSuccess() {
        viewModel = .init(viewMode: .addTask)
        let newName = "newName"
        viewModel.task.name = newName
        viewModel.task.priority = .hight
        viewModel.task.dueDate = date

        viewModel.run(action: .saveChanges)
        XCTAssertNil(viewModel.errorText)
        XCTAssert(viewModel.task.name == newName)
        XCTAssert(viewModel.task.priority == .hight)
        XCTAssert(date.compare(viewModel.task.dueDate) == .orderedSame)
    }

    func testEditChangesSuccess() {
        let taskToEdit = ToDoTask(name: "Temp", priority: .low, dueDate: date)
        viewModel = .init(viewMode: .view(task: taskToEdit))

        viewModel.run(action: .edit)
        if case .edit(taskToEdit) = viewModel.viewMode {
            XCTAssert(true)
        } else {
            XCTFail()
        }

        let newName = "newName"
        viewModel.task.name = newName
        viewModel.task.priority = .hight
        viewModel.task.dueDate = date

        viewModel.run(action: .saveChanges)
        XCTAssertNil(viewModel.errorText)
        XCTAssert(viewModel.task.name == newName)
        XCTAssert(viewModel.task.priority == .hight)
        XCTAssert(date.compare(viewModel.task.dueDate) == .orderedSame)
    }

    func testAddTaskFailed() {
        viewModel = .init(viewMode: .addTask)
        mockedStorage.mockedError = DataValidatorErrors.emptyName
        viewModel.run(action: .saveChanges)
        XCTAssertNotNil(viewModel.errorText)
    }
}
