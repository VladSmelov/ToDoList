//
//  ServiceLocator.swift
//  ToDoList
//
//  Created by Vladislav Smelov on 10/20/24.
//

import Foundation

final class ServiceLocator {
    static let storage: ToDoTaskStorageProtocol = ToDoTaskStorage()
}
