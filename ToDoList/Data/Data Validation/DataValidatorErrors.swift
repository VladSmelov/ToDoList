//
//  DataValidatorErrors.swift
//  ToDoList
//
//  Created by Vladislav Smelov on 10/21/24.
//

import Foundation

enum DataValidatorErrors: Error, LocalizedError {
    case emptyName
    case nameIsTooLong
    case unknownPriority

    var localizedDescription: String {
        switch self {
        case .emptyName:
            return "Empty name"
        case .nameIsTooLong:
            return "Name is too long, 24 characters max"
        case .unknownPriority:
            return "Unknown priority"
        }
    }

    var errorDescription: String? {
        return localizedDescription
    }
}
