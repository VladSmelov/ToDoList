//
//  UpdateTaskUseCase.swift
//  ToDoList
//
//  Created by Vladislav Smelov on 10/24/24.
//

import Foundation

final class UpdateTaskUseCase {
    private var taskToBeUpdated: ToDoTask

    init(taskToBeUpdated: ToDoTask) {
        self.taskToBeUpdated = taskToBeUpdated
    }

    func execute() throws {
        try ServiceLocator.shared.storage.update(task: taskToBeUpdated)
        try ServiceLocator.shared.localNotificationsStorage.update(for: taskToBeUpdated)
    }
}
