//
//  ToDoTaskFilter.swift
//  ToDoList
//
//  Created by Vladislav Smelov on 10/21/24.
//

import Foundation

enum ToDoTaskFilter: CaseIterable {
    static var allCases: [ToDoTaskFilter] = [
        .priority(.low),
        .priority(.medium),
        .priority(.hight),
        .none
    ]

    case priority(ToDoTask.Priority)
    case none

    func filter(tasks: [ToDoTask]) -> [ToDoTask] {
        var result: [ToDoTask]
        switch self {
        case .priority(let priority):
            result = PriorityToDoTaskFilter().filter(tasks: tasks, with: priority)
        case .none:
            result = tasks
        }
        return result
    }

    var userFriendlyName: String {
        var result = ""
        switch self {
        case .priority(let priority):
            result = "Show \(priority.asString)"
        case .none:
            result = "Show All"
        }
        return result
    }
}

private struct PriorityToDoTaskFilter {
    func filter(tasks: [ToDoTask], with priority: ToDoTask.Priority) -> [ToDoTask] {
        tasks.filter { $0.priority == priority }
    }
}
