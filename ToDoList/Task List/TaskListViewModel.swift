//
//  TaskListViewModel.swift
//  ToDoList
//
//  Created by Vladislav Smelov on 10/20/24.
//

import Foundation

class TaskListViewModel: ObservableObject {
    @Published private var tasks: [ToDoTask]
    @Published var tasksToDisplay: [ToDoTask]
    @Published private(set) var action: Action?
    private(set) var errorText: String?

    init() {
        tasks = []
        tasksToDisplay = []
    }
}

// MARK: - Actions
extension TaskListViewModel {
    func run(action: Action) {
        self.action = action
    }

    enum Action {
        case addTask
        case view(task: ToDoTask)
    }
}

// MARK: - Data manipulation
extension TaskListViewModel {
    func fetchTasks() {
        do {
            let newList = try ServiceLocator.shared.storage.fetchTasks()
            update(tasks: newList)
        } catch {
            errorText = error.localizedDescription
        }
    }

    func deleteTask(at offsets: IndexSet) {
        let index = offsets[offsets.startIndex]
        let taskToDelete = tasksToDisplay[index]
        do {
            try ServiceLocator.shared.storage.delete(task: taskToDelete)
            fetchTasks()
        } catch {
            errorText = error.localizedDescription
        }
    }

    private func update(tasks newTasks: [ToDoTask]) {
        tasks = newTasks
        tasksToDisplay = tasks
    }
}

// MARK: - Sotring
extension TaskListViewModel {
    var allSortingOptions: [ToDoTaskSorter] {
        ToDoTaskSorter.allCases
    }
    // TODO: Make private, call with using Action
    func sort(by sortingOption: ToDoTaskSorter) {
        tasksToDisplay = sortingOption.sort(tasks: tasksToDisplay)
    }
}

// MARK: - Filtering
extension TaskListViewModel {
    var allFilteringOptions: [ToDoTaskFilter] {
        ToDoTaskFilter.allCases
    }
    // TODO: Make private, call with using Action
    func filter(by filteringOption: ToDoTaskFilter) {
        tasksToDisplay = filteringOption.filter(tasks: tasks)
    }
}
