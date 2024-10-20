//
//  ToDoTaskStorage.swift
//  ToDoList
//
//  Created by Vladislav Smelov on 10/20/24.
//

import Foundation

protocol ToDoTaskStorageProtocol {
    func fetchTasks() -> [ToDoTask]
    func add(task: ToDoTask) -> Result<Bool, Error>
    func update(task: ToDoTask) -> Result<Bool, Error>
    func delete(task: ToDoTask) -> Result<Bool, Error>
}

final class ToDoTaskStorage: ToDoTaskStorageProtocol {
    var tasks: [ToDoTask] = []

    func fetchTasks() -> [ToDoTask] {

    }

    func add(task: ToDoTask) -> Result<Bool, Error> {
        <#code#>
    }

    func update(task: ToDoTask) -> Result<Bool, Error> {
        <#code#>
    }

    func delete(task: ToDoTask) -> Result<Bool, Error> {
        <#code#>
    }

    private func generateTasks() -> [ToDoTask] {
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
}
