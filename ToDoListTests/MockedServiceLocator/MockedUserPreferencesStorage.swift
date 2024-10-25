//
//  MockedUserPreferencesStorage.swift
//  ToDoListTests
//
//  Created by Vladislav Smelov on 10/24/24.
//

import XCTest
@testable import ToDoList

final class MockedUserPreferencesStorage: UserPreferencesStorageProtocol {
    var newFilteringOption: ToDoTaskFilteringOption?
    func save(filteringOption: ToDoTaskFilteringOption) {
        newFilteringOption = filteringOption
    }

    func readFilteringOption() -> ToDoTaskFilteringOption {
        newFilteringOption ?? .none
    }

    var newSortingOption: ToDoTaskSortingOption?
    func save(sortingOption: ToDoTaskSortingOption) {
        newSortingOption = sortingOption
    }

    func readSortingOption() -> ToDoTaskSortingOption {
        newSortingOption ?? .name
    }
}
