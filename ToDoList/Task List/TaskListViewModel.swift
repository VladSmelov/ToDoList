//
//  TaskListViewModel.swift
//  ToDoList
//
//  Created by Vladislav Smelov on 10/20/24.
//

import Foundation

class TaskListViewModel: ObservableObject {
    @Published var tasks: [Task]
    @Published private(set) var action: Action?

    init() {
        self.tasks = []
        fetchTasks()
    }
}

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
        for index in 0...10 {
            let newTask = Task(name: "Tast \(index)", priority: .low, dueDate: .now)
            tasks.append(newTask)
        }
    }

    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
}
