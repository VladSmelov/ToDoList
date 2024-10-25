//
//  MockedToDoTaskStorage.swift
//  ToDoListTests
//
//  Created by Vladislav Smelov on 10/21/24.
//

import Foundation
@testable import ToDoList

protocol MockedToDoTaskStorageProtocol {
    var mockedError: Error? { get set }
    var mockedFetchResult: [ToDoTask] { get set }
}

final class MockedToDoTaskStorage: ToDoTaskStorageProtocol {
    var mockedError: Error?

    var mockedFetchResult: [ToDoTask] = []
    func fetchTasks() throws -> [ToDoTask] {
        try throwErrorIfPresent()
        return mockedFetchResult
    }

    func add(task: ToDoTask) throws {
        try throwErrorIfPresent()
    }

    func update(task: ToDoTask) throws {
        try throwErrorIfPresent()
    }

    var deletedTask: ToDoTask?
    func delete(task: ToDoTask) throws {
        try throwErrorIfPresent()
        deletedTask = task
    }

    private func throwErrorIfPresent() throws {
        guard let mockedError else { return }
        throw mockedError
    }
}
