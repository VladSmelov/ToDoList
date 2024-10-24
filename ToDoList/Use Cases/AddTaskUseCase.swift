//
//  AddTaskUseCase.swift
//  ToDoList
//
//  Created by Vladislav Smelov on 10/24/24.
//

import Foundation

final class AddTaskUseCase {
    private var taskToBeAdded: ToDoTask

    init(taskToBeAdded: ToDoTask) {
        self.taskToBeAdded = taskToBeAdded

    }

    func execute() throws {
        try ServiceLocator.shared.storage.add(task: taskToBeAdded)
        try ServiceLocator.shared.localNotificationsStorage.schedule(from: taskToBeAdded)
    }
}
