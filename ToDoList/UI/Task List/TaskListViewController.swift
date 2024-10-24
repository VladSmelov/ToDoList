//
//  TaskListViewController.swift
//  ToDoList
//
//  Created by Vladislav Smelov on 10/20/24.
//

import Combine
import UIKit

class TaskListViewController: BaseViewController<TaskListView> {
    private let taskListViewModel: TaskListViewModel
    private var cancellableStorage: Set<AnyCancellable> = .init()

    init() {
        taskListViewModel = .init()
        super.init(content: TaskListView(viewModel: taskListViewModel))
        subscribeOnModalActions()
    }
}

// MARK: - Action Handling
private extension TaskListViewController {
    func subscribeOnModalActions() {
        taskListViewModel
            .$action
            .receive(on: RunLoop.main)
            .sink { [weak self] newAction in
                self?.handle(action: newAction)
            }
            .store(in: &cancellableStorage)
    }

    func handle(action: TaskListViewModel.Action?) {
        switch action {
        case .addTask:
            navigateToAddTask()
        case .view(let task):
            navigateToView(task: task)
        default:
            break
        }
    }
}

// MARK: - Navigation
private extension TaskListViewController {
    func navigateToAddTask() {
        let addTaskViewController = TaskContentViewController.addNew()
        navigationController?.pushViewController(addTaskViewController, animated: true)
    }

    func navigateToView(task: ToDoTask) {
        let viewTaskViewController = TaskContentViewController.init(view: task)
        navigationController?.pushViewController(viewTaskViewController, animated: true)
    }
}
