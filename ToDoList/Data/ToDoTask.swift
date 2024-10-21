//
//  ToDoTask.swift
//  ToDoList
//
//  Created by Vladislav Smelov on 10/20/24.
//

import Foundation

struct ToDoTask: Equatable {
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
                return "Med"
            case .hight:
                return "High"
            }
        }
    }

    static func == (lhs: ToDoTask, rhs: ToDoTask) -> Bool {
        lhs.id == rhs.id
    }
}
