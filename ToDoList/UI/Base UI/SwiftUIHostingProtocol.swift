//
//  SwiftUIHostingProtocol.swift
//  ToDoList
//
//  Created by Vladislav Smelov on 10/20/24.
//

import Foundation
import UIKit
import SwiftUI

/**
 Protocol describes a minimum vars and funcs that need to be implemented to be able to represent any `SwiftUI.View` on `UIKit` with using `UIHostingController`.
 Methods `addHostingController`, `addConstraints`, and `removeHostingController` are implemented in protocol extension.
 */
public protocol SwiftUIHostingProtocol: UIViewController {
    associatedtype Content: View
    var hostingController: UIHostingController<Content> { get }
    var view: UIView! { get }
    /// Returns UIView of `hostingController`
    var subView: UIView { get }

    /// Method adds `hostingController` as a child to instance of `UIViewController`, adds `subView` as subView to `UIViewController.view`.
    /// In protocol extension this method calls `addConstraints`.
    func addHostingController()
    /// Method activates a set of constraints for `subView` positioning
    func addConstraints()
    /// Method removes `subView` from superView and `hostingController` from parent `UIViewController`. This method must be called in `didReceiveMemoryWarning` and `deinit` methods.
    func removeHostingController()
}

public extension SwiftUIHostingProtocol {
    var subView: UIView {
        let hostingControllerAsViewController = hostingController as UIViewController
        guard
            let view = hostingControllerAsViewController.view
        else {
            assertionFailure("UIHostingController doesn't have view.")
            return UIView()
        }
        view.backgroundColor = .clear
        return view
    }

    func addHostingController() {
        addChild(hostingController)
        view.addSubview(subView)
        addConstraints()
        hostingController.didMove(toParent: self)
    }

    func removeHostingController() {
        subView.removeFromSuperview()
        hostingController.willMove(toParent: nil)
        hostingController.removeFromParent()
    }

    func addConstraints() {
        subView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subView.topAnchor.constraint(equalTo: view.topAnchor),
            subView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            subView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            subView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
        ])
    }
}
