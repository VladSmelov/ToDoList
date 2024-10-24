//
//  ToDoTaskSortingOption.swift
//  ToDoList
//
//  Created by Vladislav Smelov on 10/20/24.
//

import Foundation

enum ToDoTaskSortingOption: Int, CaseIterable {
    case name
    case dueDate
    case priority

    var userFriendlyName: String {
        var result = ""
        switch self {
        case .name:
            result = "By Name"
        case .dueDate:
            result = "By Due Date"
        case .priority:
            result = "By Priority"
        }
        return result
    }
}
