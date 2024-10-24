//
//  ToDoTaskFilteringOption.swift
//  ToDoList
//
//  Created by Vladislav Smelov on 10/21/24.
//

import Foundation

enum ToDoTaskFilteringOption: CaseIterable {
    static var allCases: [ToDoTaskFilteringOption] = [
        .priority(.low),
        .priority(.medium),
        .priority(.hight),
        .none
    ]

    case priority(ToDoTask.Priority)
    case none

    init(caseNumber: Int) {
        guard 0 <= caseNumber && caseNumber < Self.allCases.count else {
            self = .none
            return
        }
        self = Self.allCases[caseNumber]
    }

    var caseNumber: Int {
        var result = 0
        switch self {
        case .priority(let priority):
            switch priority {
            case .low:
                result = 0
            case .medium:
                result = 1
            case .hight:
                result = 2
            case .unknown:
                result = -1
            }
        case .none:
            result = 3
        }
        return result
    }

    var userFriendlyName: String {
        var result = ""
        switch self {
        case .priority(let priority):
            result = "Show \(priority.userFriendlyName)"
        case .none:
            result = "Show All"
        }
        return result
    }
}

