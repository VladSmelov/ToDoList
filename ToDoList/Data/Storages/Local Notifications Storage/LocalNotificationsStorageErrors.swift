//
//  LocalNotificationsStorageErrors.swift
//  ToDoList
//
//  Created by Vladislav Smelov on 10/24/24.
//

import Foundation

enum LocalNotificationsStorageErrors: Error, LocalizedError {
    case notificationWasNotScheduled

    var localizedDescription: String {
        switch self {
        case .notificationWasNotScheduled:
            return "Notification was not scheduled"
        }
    }

    var errorDescription: String? {
        return localizedDescription
    }
}

