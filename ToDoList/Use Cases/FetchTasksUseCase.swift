//
//  FetchTasksUseCase.swift
//  ToDoList
//
//  Created by Vladislav Smelov on 10/24/24.
//

import Foundation

final class FetchTasksUseCase {
    typealias FetchResult = (allTasks: [ToDoTask], tasksToDisplay: [ToDoTask])

    func execute() throws -> FetchResult {
        let tasks = try ServiceLocator.shared.storage.fetchTasks()
        var tasksToDisplay = filter(savedTasks: tasks)
        tasksToDisplay = sort(savedTasks: tasksToDisplay)
        return (tasks, tasksToDisplay)
    }
}

private extension FetchTasksUseCase {
    func filter(savedTasks: [ToDoTask]) -> [ToDoTask] {
        let filterUseCase = FilterTasksUseCase(tasks: savedTasks, filteringOption: savedFilteringOption)
        return filterUseCase.execute()
    }

    var savedFilteringOption: ToDoTaskFilteringOption {
        ServiceLocator.shared.userPreferences.readFilteringOption()
    }

    func sort(savedTasks: [ToDoTask]) -> [ToDoTask] {
        let sortUseCase = SortTasksUseCase(tasks: savedTasks, sortingOption: savedSortingOption)
        return sortUseCase.execute()
    }

    var savedSortingOption: ToDoTaskSortingOption {
        ServiceLocator.shared.userPreferences.readSortingOption()
    }
}
