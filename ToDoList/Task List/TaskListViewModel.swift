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

    init() {
        tasks = []
        tasksToDisplay = []
        fetchTasks()
    }
}

// MARK: - Actions
extension TaskListViewModel {
    func run(action: Action) {
        self.action = action
        self.action = nil
    }

    enum Action {
        case addTask
    }
}

// MARK: - Data manipulation
extension TaskListViewModel {
    func fetchTasks() {
        do {
            let newList = try ServiceLocator.storage.fetchTasks()
            update(tasks: newList)
        } catch {
            print(error)
        }
    }

    func deleteTask(at offsets: IndexSet) {
        let index = offsets[offsets.startIndex]
        let taskToDelete = tasksToDisplay[index]
        do {
            try ServiceLocator.storage.delete(task: taskToDelete)
            fetchTasks()
        } catch {
            print(error)
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

    func sort(by sortingOption: ToDoTaskSorter) {
        tasksToDisplay = sortingOption.sort(tasks: tasksToDisplay)
    }
}

// MARK: - Filtering
extension TaskListViewModel {
    var allFilteringOptions: [ToDoTaskFilter] {
        ToDoTaskFilter.allCases
    }

    func filter(by filteringOption: ToDoTaskFilter) {
        tasksToDisplay = filteringOption.filter(tasks: tasks)
    }
}
