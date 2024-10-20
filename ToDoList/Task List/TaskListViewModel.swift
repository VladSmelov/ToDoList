//
//  TaskListViewModel.swift
//  ToDoList
//
//  Created by Vladislav Smelov on 10/20/24.
//

import Foundation

struct Task {
    let id: UUID = .init()
    let name: String
    let priority: Int
    let dueDate: Date
}

class TaskListViewModel: ObservableObject {
    @Published var tasks: [Task]

    init() {
        self.tasks = []
        fetchTasks()
    }

    func fetchTasks() {
        for index in 0..<100 {
            let newTask = Task(name: "Tast \(index)", priority: index, dueDate: .now)
            tasks.append(newTask)
        }
    }
}
