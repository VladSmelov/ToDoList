//
//  AddTaskViewController.swift
//  ToDoList
//
//  Created by Vladislav Smelov on 10/20/24.
//

import Combine
import UIKit

class AddTaskViewController: BaseViewController<AddTaskView> {
    private let addTaskViewModel: AddTaskViewModel
    private var cancellableStorage: Set<AnyCancellable> = .init()

    init() {
        addTaskViewModel = .init()
        super.init(content: AddTaskView(viewModel: addTaskViewModel))
        subscribeOnModalActions()
    }
}

// MARK: - Action Handling
private extension AddTaskViewController {
    func subscribeOnModalActions() {
        addTaskViewModel
            .$action
            .receive(on: RunLoop.main)
            .sink { [weak self] newAction in
                self?.handle(action: newAction)
            }
            .store(in: &cancellableStorage)
    }

    func handle(action: AddTaskViewModel.Action?) {
        switch action {
        case .goBack:
            navigateBack()
        default:
            break
        }
    }
}

// MARK: - Navigation
private extension AddTaskViewController {
    func navigateBack() {
        navigationController?.popViewController(animated: true)
    }
}
