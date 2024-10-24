//
//  FilterTasksUseCase.swift
//  ToDoList
//
//  Created by Vladislav Smelov on 10/24/24.
//

import Foundation

final class FilterTasksUseCase {
    private var filteringOption: ToDoTaskFilteringOption
    private var tasks: [ToDoTask]

    init(tasks: [ToDoTask], filteringOption: ToDoTaskFilteringOption) {
        self.tasks = tasks
        self.filteringOption = filteringOption
    }

    func execute() -> [ToDoTask] {
        saveLastUsedOption()
        return filter()
    }
}

private extension FilterTasksUseCase {
    func saveLastUsedOption() {
        ServiceLocator.shared.userPreferences.save(filteringOption: filteringOption)
    }

    func filter() -> [ToDoTask] {
        var result: [ToDoTask]
        switch filteringOption {
        case .priority(let priority):
            result = PriorityToDoTaskFilter().filter(tasks: tasks, with: priority)
        case .none:
            result = tasks
        }
        return result
    }
}

// MARK: Filters
private struct PriorityToDoTaskFilter {
    func filter(tasks: [ToDoTask], with priority: ToDoTask.Priority) -> [ToDoTask] {
        tasks.filter { $0.priority == priority }
    }
}
