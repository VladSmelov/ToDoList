//
//  ToDoTask.swift
//  ToDoList
//
//  Created by Vladislav Smelov on 10/20/24.
//

import Foundation

struct ToDoTask: Equatable {
    let id: UUID = .init()
    var name: String
    var priority: Priority
    var dueDate: Date

    enum Priority: Int, CaseIterable {
        case low
        case medium
        case hight
        /// Dummy Priority, designed to be able to throw errors during task data validation
        case unknown

        var userFriendlyName: String {
            switch self {
            case .low:
                return "Low"
            case .medium:
                return "Med"
            case .hight:
                return "High"
            case .unknown:
                return "Unknown"
            }
        }
    }
    
    var userFriendlyDueDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: dueDate)
    }

    static func == (lhs: ToDoTask, rhs: ToDoTask) -> Bool {
        lhs.id == rhs.id
    }
}
