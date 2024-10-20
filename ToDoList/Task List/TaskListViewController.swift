//
//  TaskListViewController.swift
//  ToDoList
//
//  Created by Vladislav Smelov on 10/20/24.
//

import UIKit

class TaskListViewController: BaseViewController<TaskListView> {
    private let taskListViewModel: TaskListViewModel

    init() {
        taskListViewModel = .init()
        super.init(content: TaskListView(viewModel: taskListViewModel))
    }
}
