//
//  DataValidator.swift
//  ToDoList
//
//  Created by Vladislav Smelov on 10/21/24.
//

import Foundation

final class DataValidator: DataValidatorProtocol {
    func validate(task: ToDoTask) throws {
        try validate(name: task.name)
        try validate(priority: task.priority)
    }
}

private extension DataValidator {
    func validate(name: String) throws {
        guard !name.isEmpty else {
            throw DataValidatorErrors.emptyName
        }
        guard name.count < 25 else {
            throw DataValidatorErrors.nameIsTooLong
        }
    }

    func validate(priority: ToDoTask.Priority) throws {
        guard
            0 <= priority.rawValue,
            priority.rawValue <= 2
        else {
            throw DataValidatorErrors.unknownPriority
        }
    }
}
