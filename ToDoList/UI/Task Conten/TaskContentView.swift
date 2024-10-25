//
//  TaskContentView.swift
//  ToDoList
//
//  Created by Vladislav Smelov on 10/20/24.
//

import SwiftUI

struct TaskContentView: View {
    @ObservedObject private(set) var viewModel: TaskContentViewModel

    var body: some View {
        BaseNavigationView {
            mainContent
        } toolBar: {
            ToolbarItem(placement: .navigation) {
                backArrow
            }
            ToolbarItem(placement: .principal) {
                Text(Localized.title.value)
            }
            if case .view(_) = viewModel.viewMode {
                ToolbarItem(placement: .topBarTrailing) {
                    editButton
                }
            }
        }
    }
}

// MARK: - Sub Views
private extension TaskContentView {
    var backArrow: some View {
        Button {
            viewModel.run(action: .goBack)
        } label: {
            Image(systemName: "chevron.backward")
        }
    }

    var editButton: some View {
        Button {
            viewModel.run(action: .edit)
        } label: {
            Image(systemName: "pencil.line")
        }
    }

    @ViewBuilder
    var mainContent: some View {
        switch viewModel.viewMode {
        case .view:
            viewTaskDetails
        case .edit, .addTask:
            editTaskDetails
        }
    }
}

private extension TaskContentView {
    var viewTaskDetails: some View {
        List {
            Section {
                Text(viewModel.task.name)
                    .padding(.vertical, 8)
            } header: {
                Text(Localized.nameSection.value)
            }

            Section {
                Text(viewModel.task.userFriendlyDueDate)
                    .padding(.vertical, 8)
            } header: {
                Text(Localized.dueDateSection.value)
            }

            Section {
                Text(viewModel.task.priority.userFriendlyName)
                    .padding(.vertical, 8)
            } header: {
                Text(Localized.prioritySection.value)
            }
        }
    }

    var editTaskDetails: some View {
        List {
            Section {
                TextField(
                    text: $viewModel.task.name,
                    prompt: Text(Localized.taskNamePlaceholder.value)
                ) { }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .labelsHidden()
                    .padding(.vertical, 8)
            } header: {
                Text(Localized.nameSection.value)
            }

            Section {
                DatePicker(
                    selection: $viewModel.task.dueDate,
                    in: viewModel.task.dueDate...,
                    displayedComponents: .date
                ) { }
                    .labelsHidden()
                    .padding(.vertical, 8)
            } header: {
                Text(Localized.dueDateSection.value)
            }

            Section {
                Picker("", selection: $viewModel.task.priority) {
                    ForEach(ToDoTask.Priority.allCases, id: \.rawValue) {
                        Text($0.userFriendlyName)
                            .tag($0)
                    }
                }
                .labelsHidden()
                .padding(.vertical, 8)
            } header: {
                Text(Localized.prioritySection.value)
            }

            Button {
                viewModel.run(action: .saveChanges)
            } label: {
                Text(Localized.saveButtonTitle.value)
                    .padding(.vertical, 8)
            }
            .clipShape(Capsule())
            
            showErrorLabel()
        }
    }
    
    @ViewBuilder
    func showErrorLabel() -> some View {
        if let errorText = viewModel.errorText {
            Text(errorText)
                .foregroundColor(.red)
                .padding(.vertical, 8)
        }
    }
}

private extension TaskContentView {
    // Mock enum that can be used for localization
    enum Localized: String {
        case title = "To-Do List"
        case nameSection = "Name"
        case dueDateSection = "Due date"
        case prioritySection = "Priority"
        case taskNamePlaceholder = "Enter Task name"
        case saveButtonTitle = "Save"

        var value: String {
            rawValue
        }
    }
}

#Preview {
    let toDoTask = ToDoTask(name: "ToDoTask", priority: .medium, dueDate: .now)
    return TaskContentView(viewModel: .init(viewMode: .view(task: toDoTask)))
}
