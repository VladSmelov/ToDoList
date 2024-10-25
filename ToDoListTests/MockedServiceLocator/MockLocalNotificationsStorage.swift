//
//  MockLocalNotificationsStorage.swift
//  ToDoListTests
//
//  Created by Vladislav Smelov on 10/24/24.
//

import Foundation
@testable import ToDoList

final class MockLocalNotificationsStorage: LocalNotificationsStorageProtocol {
    var scheduledTask: ToDoTask?
    func schedule(from task: ToDoTask) throws {
        scheduledTask = task
    }

    var updatedTask: ToDoTask?
    func update(for task: ToDoTask) throws {
        updatedTask = task
    }

    var deleteTask: ToDoTask?
    func delete(for task: ToDoTask) throws {
        deleteTask = task
    }
}
