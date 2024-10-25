//
//  UserPreferencesStorage.swift
//  ToDoList
//
//  Created by Vladislav Smelov on 10/24/24.
//

import Foundation

final class UserPreferencesStorage: UserPreferencesStorageProtocol {
    func save(sortingOption: ToDoTaskSortingOption) {
        UserDefaults.standard.set(sortingOption.rawValue, forKey: Keys.sortingOption.rawValue)
    }

    func readSortingOption() -> ToDoTaskSortingOption {
        let option = UserDefaults.standard.integer(forKey: Keys.sortingOption.rawValue)
        return ToDoTaskSortingOption(rawValue: option) ?? .name
    }

    func save(filteringOption: ToDoTaskFilteringOption) {
        UserDefaults.standard.set(filteringOption.caseNumber, forKey: Keys.filteringOption.rawValue)
    }

    func readFilteringOption() -> ToDoTaskFilteringOption {
        guard UserDefaults.standard.value(forKey: Keys.filteringOption.rawValue) != nil else {
            return .none
        }
        let option = UserDefaults.standard.integer(forKey: Keys.filteringOption.rawValue)
        return ToDoTaskFilteringOption(caseNumber: option)
    }
}

private extension UserPreferencesStorage {
    enum Keys: String {
        case sortingOption
        case filteringOption
    }
}
