//
//  ToDoTaskStorage.swift
//  ToDoList
//
//  Created by Vladislav Smelov on 10/20/24.
//

import Foundation

final class ToDoTaskStorage: ToDoTaskStorageProtocol {
    private var tasks: [ToDoTask] = []

    init() {
        tasks = generateTasks()
    }

    func fetchTasks() throws -> [ToDoTask] {
        guard !tasks.isEmpty else {
            throw ToDoTaskStorageErrors.emptyStorage
        }
        return tasks
    }

    func add(task: ToDoTask) throws {
        try validate(task: task)
        tasks.append(task)
    }

    func update(task: ToDoTask) throws {
        try validate(task: task)
        guard let index = tasks.firstIndex(of: task) else {
            throw ToDoTaskStorageErrors.noTaskInStorage(task)
        }
        tasks[index] = task
    }

    func delete(task: ToDoTask) throws {
        guard let index = tasks.firstIndex(of: task) else {
            throw ToDoTaskStorageErrors.noTaskInStorage(task)
        }
        tasks.remove(at: index)
    }
}

// MARK: - Helpers
private extension ToDoTaskStorage {
    func generateTasks() -> [ToDoTask] {
        // TODO: read data from storage
        var result = [ToDoTask]()
        let numberOfTasks = Int.random(in: 10...20)
        for _ in 0...numberOfTasks {
            let newTask = ToDoTask(
                name: "\(Int.random(in: 0...100)) Task",
                priority: .init(rawValue: Int.random(in: 0...2))!,
                dueDate: .now.addingTimeInterval(TimeInterval.random(in: 0...100) * 24 * 60 * 60))
            result.append(newTask)
        }
        return result
    }

    func validate(task: ToDoTask) throws {
        try ServiceLocator.shared.dataValidator.validate(task: task)
    }
}

