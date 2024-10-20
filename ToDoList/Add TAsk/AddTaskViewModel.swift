//
//  AddTaskViewModel.swift
//  ToDoList
//
//  Created by Vladislav Smelov on 10/20/24.
//

import Foundation

class AddTaskViewModel: ObservableObject {
    @Published private(set) var task: ToDoTask
    @Published private(set) var action: Action?

    init() {
        task = ToDoTask(name: "", priority: .low, dueDate: .now)
    }
}

extension AddTaskViewModel {
    enum Action {
        case goBack
    }

    func run(action: Action) {
        self.action = action
    }
}
