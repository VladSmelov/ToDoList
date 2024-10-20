//
//  Task.swift
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
