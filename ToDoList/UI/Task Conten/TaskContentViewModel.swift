//
//  TaskContentViewModel.swift
//  ToDoList
//
//  Created by Vladislav Smelov on 10/20/24.
//

import Foundation

class TaskContentViewModel: ObservableObject {
    @Published var viewMode: ViewMode
    @Published var task: ToDoTask
    @Published private(set) var action: Action?
    @Published private(set) var errorText: String?

    init(viewMode: ViewMode) {
        self.viewMode = viewMode
        switch viewMode {
        case .view(let inputTask), .edit(let inputTask):
            task = inputTask
        case .addTask:
            task = ToDoTask(name: "", priority: .low, dueDate: .now)
        }
    }
}

extension TaskContentViewModel {
    enum ViewMode {
        case view(task: ToDoTask)
        case edit(task: ToDoTask)
        case addTask
    }

    enum Action {
        case goBack
        case saveChanges
        case edit
    }

    func run(action: Action) {
        self.action = action

        switch action {
        case .saveChanges:
            saveChanges()
        case .edit:
            switchToEditMode()
        default:
            break
        }
    }
}

private extension TaskContentViewModel {
    func switchToEditMode() {
        viewMode = .edit(task: task)
    }

    func saveChanges() {
        errorText = nil
        do {
            switch viewMode {
            case .addTask:
                try AddTaskUseCase(taskToBeAdded: task).execute()
            case .edit:
                try UpdateTaskUseCase(taskToBeUpdated: task).execute()
            default:
                break
            }
            onChangesSaved()
        } catch {
            errorText = error.localizedDescription
        }
    }

    func onChangesSaved() {
        viewMode = .view(task: task)
    }
}
