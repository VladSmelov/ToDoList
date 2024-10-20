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
        for _ in 0...10 {
            let newTask = ToDoTask(
                name: "\(Int.random(in: 0...100)) Task",
                priority: .init(rawValue: Int.random(in: 0...2))!,
                dueDate: .now.addingTimeInterval(TimeInterval.random(in: 0...100) * 24 * 60 * 60))
            tasks.append(newTask)
        }
    }

    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
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
