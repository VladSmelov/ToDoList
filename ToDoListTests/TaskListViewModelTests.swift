//
//  TaskListViewModelTests.swift
//  ToDoListTests
//
//  Created by Vladislav Smelov on 10/21/24.
//

import XCTest
@testable import ToDoList

final class TaskListViewModelTests: XCTestCase {
    // TODO: DRY
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
        ServiceLocator.shared = .init(
            storage: mockedStorage,
            userPreferences: MockedUserPreferencesStorage())
        mockedStorage.mockedFetchResult = mockedTaskList
    }

    func testFetchDataSuccess() {
        viewModel.run(action: .fetch)
        XCTAssert(viewModel.tasksToDisplay.count == mockedTaskList.count)
        XCTAssertNil(viewModel.errorText)
    }

    func testFetchDataFailed() {
        mockedStorage.mockedError = ToDoTaskStorageErrors.emptyStorage
        viewModel.run(action: .fetch)

        XCTAssert(viewModel.tasksToDisplay.isEmpty)
        XCTAssert(viewModel.errorText == ToDoTaskStorageErrors.emptyStorage.localizedDescription)
    }

    func testDeleteTaskSuccess() {
        viewModel.run(action: .fetch)
        viewModel.run(action: .deleteTask(atIndex: IndexSet(integer: 1)))
        XCTAssertFalse(mockedTaskList[1] == mockedStorage.deletedTask)
    }

    func testDeleteTaskFailed() {
        viewModel.run(action: .fetch)
        mockedStorage.mockedError = ToDoTaskStorageErrors.emptyStorage
        viewModel.run(action: .deleteTask(atIndex: IndexSet(integer: 1)))
        XCTAssert(viewModel.errorText == ToDoTaskStorageErrors.emptyStorage.localizedDescription)
    }
}
