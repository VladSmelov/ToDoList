//
//  LocalNotificationsStorageProtocol.swift
//  ToDoList
//
//  Created by Vladislav Smelov on 10/24/24.
//

import Foundation

protocol LocalNotificationsStorageProtocol {
    func schedule(from task: ToDoTask) throws
    func delete(for task: ToDoTask) throws
    func update(for task: ToDoTask) throws
}
