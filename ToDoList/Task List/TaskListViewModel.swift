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
    let priority: Priority
    let dueDate: Date

    enum Priority: Int {
        case low
        case medium
        case hight

        var asString: String {
            switch self {
            case .low:
                return "Low"
            case .medium:
                return "Medium"
            case .hight:
                return "Hight"
            }
        }
    }
}

class TaskListViewModel: ObservableObject {
    @Published var tasks: [Task]

    init() {
        self.tasks = []
        fetchTasks()
    }
}

// MARK: - Data manipulation
extension TaskListViewModel {
    func fetchTasks() {
        for index in 0..<100 {
            let newTask = Task(name: "Tast \(index)", priority: .low, dueDate: .now)
            tasks.append(newTask)
        }
    }
}
