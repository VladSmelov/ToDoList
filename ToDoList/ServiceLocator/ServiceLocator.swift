//
//  ServiceLocator.swift
//  ToDoList
//
//  Created by Vladislav Smelov on 10/20/24.
//

import Foundation

final class ServiceLocator {
    static var shared: ServiceLocator = .init()

    private(set) var storage: ToDoTaskStorageProtocol
    private(set) var dataValidator: DataValidatorProtocol
    private(set) var userPreferences: UserPreferencesStorageProtocol
    private(set) var localNotificationsStorage: LocalNotificationsStorageProtocol

    init(
        storage: some ToDoTaskStorageProtocol = ToDoTaskStorage(),
        dataValidator: some DataValidatorProtocol = DataValidator(),
        userPreferences: some UserPreferencesStorageProtocol = UserPreferencesStorage(),
        localNotificationsStorage: some LocalNotificationsStorageProtocol = LocalNotificationsStorage()
    ) {
        self.storage = storage
        self.dataValidator = dataValidator
        self.userPreferences = userPreferences
        self.localNotificationsStorage = localNotificationsStorage
    }
}
