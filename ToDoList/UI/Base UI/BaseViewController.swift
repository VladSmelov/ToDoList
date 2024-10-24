//
//  BaseViewController.swift
//  ToDoList
//
//  Created by Vladislav Smelov on 10/20/24.
//

import UIKit
import SwiftUI

class BaseViewController<Content: View>: UIViewController, SwiftUIHostingProtocol {
    private(set) var hostingController: UIHostingController<Content>

    init(content: Content) {
        hostingController = .init(rootView: content)
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addHostingController()
    }

    deinit {
        removeHostingController()
    }
}
