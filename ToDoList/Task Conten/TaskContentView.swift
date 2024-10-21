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
                Text("To-Do List")
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
                Text("Name")
            }

            Section {
                Text(viewModel.task.userFriendlyDueDate)
                    .padding(.vertical, 8)
            } header: {
                Text("Due date")
            }

            Section {
                Text(viewModel.task.priority.userFriendlyName)
                    .padding(.vertical, 8)
            } header: {
                Text("Priority")
            }
        }
    }

    var editTaskDetails: some View {
        List {
            Section {
                TextField(
                    text: $viewModel.task.name,
                    prompt: Text("Enter Task name")
                ) { }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .labelsHidden()
                    .padding(.vertical, 8)
            } header: {
                Text("Name")
            }

            Section {
                DatePicker(
                    selection: $viewModel.task.dueDate,
                    in: Date.now...,
                    displayedComponents: .date
                ) { }
                    .labelsHidden()
                    .padding(.vertical, 8)
            } header: {
                Text("Due date")
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
                Text("Priority")
            }

            Button {
                viewModel.run(action: .saveChanges)
            } label: {
                Text("Save")
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

#Preview {
    let toDoTask = ToDoTask(name: "ToDoTask", priority: .medium, dueDate: .now)
    return TaskContentView(viewModel: .init(viewMode: .view(task: toDoTask)))
}
