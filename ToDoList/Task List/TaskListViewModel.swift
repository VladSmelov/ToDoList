//
//  TaskListViewModel.swift
//  ToDoList
//
//  Created by Vladislav Smelov on 10/20/24.
//

import Foundation

class TaskListViewModel: ObservableObject {
    @Published var tasks: [ToDoTask]
    @Published private(set) var action: Action?

    init() {
        self.tasks = []
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
            tasks = try ServiceLocator.storage.fetchTasks()
        } catch {
            print(error)
        }
    }

    func deleteTask(at offsets: IndexSet) {
        let index = offsets[offsets.startIndex]
        var deletedTask = tasks[index]
        do {
            try ServiceLocator.storage.delete(task: deletedTask)
            fetchTasks()
        } catch {
            print(error)
        }
    }
}

// MARK: - Sotring
extension TaskListViewModel {
    var allSortingOptions: [ToDoTaskSorter] {
        ToDoTaskSorter.allCases
    }

    func sort(by sortingOption: ToDoTaskSorter) {
        tasks = sortingOption.sort(tasks: tasks)
    }
}
