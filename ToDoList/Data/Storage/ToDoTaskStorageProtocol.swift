//
//  ToDoTaskStorageProtocol.swift
//  ToDoList
//
//  Created by Vladislav Smelov on 10/21/24.
//

import Foundation

protocol ToDoTaskStorageProtocol {
    func fetchTasks() throws -> [ToDoTask]
    func add(task: ToDoTask) throws
    func update(task: ToDoTask) throws
    func delete(task: ToDoTask) throws
}
