//
//  UserPreferencesStorageProtocol.swift
//  ToDoList
//
//  Created by Vladislav Smelov on 10/24/24.
//

import Foundation

protocol UserPreferencesStorageProtocol {
    func save(sortingOption: ToDoTaskSortingOption)
    func readSortingOption() -> ToDoTaskSortingOption
    func save(filteringOption: ToDoTaskFilteringOption)
    func readFilteringOption() -> ToDoTaskFilteringOption
}
