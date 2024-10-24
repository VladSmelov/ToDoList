//
//  SortTasksUseCase.swift
//  ToDoList
//
//  Created by Vladislav Smelov on 10/24/24.
//

import Foundation

final class SortTasksUseCase {
    private var sortingOption: ToDoTaskSortingOption
    private var tasks: [ToDoTask]

    init(tasks: [ToDoTask], sortingOption: ToDoTaskSortingOption) {
        self.tasks = tasks
        self.sortingOption = sortingOption
    }

    func execute() -> [ToDoTask] {
        saveLastUsedOption()
        return sort()
    }
}

private extension SortTasksUseCase {
    func sort() -> [ToDoTask] {
        var result: [ToDoTask]
        switch sortingOption {
        case .name:
            result = NameTaskSorter().sort(tasks: tasks)
        case .dueDate:
            result = DueDateTaskSorter().sort(tasks: tasks)
        case .priority:
            result = PriorityTaskSorter().sort(tasks: tasks)
        }
        return result
    }

    func saveLastUsedOption() {
        ServiceLocator.shared.userPreferences.save(sortingOption: sortingOption)
    }
}

// MARK: - Sorters
protocol TaskSorterProtocol {
    var ascending: Bool { get }
    init(ascending: Bool)
    func sort(tasks: [ToDoTask]) -> [ToDoTask]
    func sortedByAscendingOrder() -> (ToDoTask, ToDoTask) throws -> Bool
    func sortedByDescendingOrder() -> (ToDoTask, ToDoTask) throws -> Bool
}

extension TaskSorterProtocol {
    func sort(tasks: [ToDoTask]) -> [ToDoTask] {
        try! tasks.sorted(by: ascending ? sortedByAscendingOrder() : sortedByDescendingOrder())
    }
}

private struct NameTaskSorter: TaskSorterProtocol {
    let ascending: Bool

    init(ascending: Bool = true) {
        self.ascending = ascending
    }

    func sortedByAscendingOrder() -> (ToDoTask, ToDoTask) throws -> Bool {
        { $0.name < $1.name }
    }

    func sortedByDescendingOrder() -> (ToDoTask, ToDoTask) throws -> Bool {
        { $0.name > $1.name }
    }
}

private struct DueDateTaskSorter: TaskSorterProtocol {
    let ascending: Bool

    init(ascending: Bool = true) {
        self.ascending = ascending
    }

    func sortedByAscendingOrder() -> (ToDoTask, ToDoTask) throws -> Bool {
        { $0.dueDate.compare($1.dueDate) == .orderedAscending }
    }

    func sortedByDescendingOrder() -> (ToDoTask, ToDoTask) throws -> Bool {
        { $0.dueDate.compare($1.dueDate) == .orderedDescending }
    }
}

private struct PriorityTaskSorter: TaskSorterProtocol {
    let ascending: Bool

    init(ascending: Bool = false) {
        self.ascending = ascending
    }

    func sortedByAscendingOrder() -> (ToDoTask, ToDoTask) throws -> Bool {
        { $0.priority.rawValue < $1.priority.rawValue }
    }

    func sortedByDescendingOrder() -> (ToDoTask, ToDoTask) throws -> Bool {
        { $0.priority.rawValue > $1.priority.rawValue }
    }
}
