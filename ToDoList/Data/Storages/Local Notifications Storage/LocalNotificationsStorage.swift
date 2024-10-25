//
//  LocalNotificationsStorage.swift
//  ToDoList
//
//  Created by Vladislav Smelov on 10/24/24.
//

import Foundation
import UserNotifications

final class LocalNotificationsStorage: LocalNotificationsStorageProtocol {
    private var permissionsProvided: Bool = false
    
    func schedule(from task: ToDoTask) throws {
        try checkPermissionsIfNeeded()
        
        let triggerAfter = Date.now.timeIntervalSince(task.dueDate)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: triggerAfter, repeats: false)

        let request = UNNotificationRequest(
            identifier: task.id.uuidString,
            content: context(for: task),
            trigger: trigger)

        UNUserNotificationCenter.current().add(request)
    }

    func update(for task: ToDoTask) throws {
        try checkPermissionsIfNeeded()
        try delete(for: task)
        try schedule(from: task)
    }

    func delete(for task: ToDoTask) throws {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [ task.id.uuidString])
    }

    private func checkPermissionsIfNeeded() throws {
        guard !permissionsProvided else {
            return
        }

        Task { @MainActor in
            do {
                permissionsProvided = try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    private func context(for task: ToDoTask) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = task.priority.userFriendlyName
        content.subtitle = task.name
        content.sound = UNNotificationSound.default
        return content
    }
}
