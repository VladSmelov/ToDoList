//
//  AppDelegate.swift
//  ToDoList
//
//  Created by Vladislav Smelov on 10/20/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = TaskListViewController()
        window?.makeKeyAndVisible()
        return true
    }
}
