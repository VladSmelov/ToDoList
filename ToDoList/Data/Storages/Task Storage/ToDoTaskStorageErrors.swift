//
//  ToDoTaskStorageErrors.swift
//  ToDoList
//
//  Created by Vladislav Smelov on 10/21/24.
//

import Foundation

enum ToDoTaskStorageErrors: Error, LocalizedError {
    case noTaskInStorage(ToDoTask)
    case emptyStorage

    var localizedDescription: String {
        switch self {
        case .noTaskInStorage(let toDoTask):
            return "Wrong task ID: \(toDoTask.id)"
        case .emptyStorage:
            return "Storage is empty"
        }
    }
    
    var errorDescription: String? {
        return localizedDescription
    }
}
