//
//  DeleteTaskUseCase.swift
//  ToDoList
//
//  Created by Vladislav Smelov on 10/24/24.
//

import Foundation

final class DeleteTaskUseCase {
    private let taskToDelete: ToDoTask

    init(taskToDelete: ToDoTask) {
        self.taskToDelete = taskToDelete
    }

    func execute() throws {
        try ServiceLocator.shared.storage.delete(task: taskToDelete)
        try ServiceLocator.shared.localNotificationsStorage.delete(for: taskToDelete)
    }
}
