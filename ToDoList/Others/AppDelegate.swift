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
        guard isRunningTests == false else {
            return true
        }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = createRootNavigationViewController()
        window?.makeKeyAndVisible()
        return true
    }

    private var isRunningTests: Bool {
        return ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
    }

    private func createRootNavigationViewController() -> UINavigationController {
        let navigationViewController = UINavigationController(rootViewController: TaskListViewController())
        navigationViewController.navigationBar.isHidden = true
        return navigationViewController
    }
}
