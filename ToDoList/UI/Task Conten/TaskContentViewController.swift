//
//  TaskContentViewController.swift
//  ToDoList
//
//  Created by Vladislav Smelov on 10/20/24.
//

import Combine
import UIKit

class TaskContentViewController: BaseViewController<TaskContentView> {
    private let taskContentViewModel: TaskContentViewModel
    private var cancellableStorage: Set<AnyCancellable> = .init()

    private init(taskContentViewModel: TaskContentViewModel) {
        self.taskContentViewModel = taskContentViewModel
        super.init(content: TaskContentView(viewModel: taskContentViewModel))
        subscribeOnModalActions()
    }

    convenience init(view task: ToDoTask) {
        let viewModel = TaskContentViewModel(viewMode: .view(task: task))
        self.init(taskContentViewModel: viewModel)
    }

    convenience init(edit task: ToDoTask) {
        let viewModel = TaskContentViewModel(viewMode: .edit(task: task))
        self.init(taskContentViewModel: viewModel)
    }

    static func addNew() -> TaskContentViewController {
        let viewModel = TaskContentViewModel(viewMode: .addTask)
        return TaskContentViewController(taskContentViewModel: viewModel)
    }
}

// MARK: - Action Handling
private extension TaskContentViewController {
    func subscribeOnModalActions() {
        taskContentViewModel
            .$action
            .receive(on: RunLoop.main)
            .sink { [weak self] newAction in
                self?.handle(action: newAction)
            }
            .store(in: &cancellableStorage)
    }

    func handle(action: TaskContentViewModel.Action?) {
        switch action {
        case .goBack:
            navigateBack()
        default:
            break
        }
    }
}

// MARK: - Navigation
private extension TaskContentViewController {
    func navigateBack() {
        navigationController?.popViewController(animated: true)
    }
}
