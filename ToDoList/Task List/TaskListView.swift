//
//  TaskListView.swift
//  ToDoList
//
//  Created by Vladislav Smelov on 10/20/24.
//

import SwiftUI

struct TaskListView: View {
    @ObservedObject private(set) var viewModel: TaskListViewModel

    var body: some View {
        BaseNavigationView {
            taskList
        } toolBar: {
            ToolbarItem(placement: .primaryAction) {
                addTaskButton
            }
            ToolbarItem(placement: .principal) {
                Text("To-Do List")
            }
        }
    }
}

// MARK: - Sub Views
private extension TaskListView {
    var addTaskButton: some View {
        Button {
            viewModel.run(action: .addTask)
        } label: {
            Image(systemName: "plus.circle")
        }
    }

    var taskList: some View {
        List {
            ForEach(viewModel.tasks, id: \.id) { task in
                cell(for: task)
            }
            .onDelete(perform: viewModel.deleteTask)
        }
    }

    func cell(for task: Task) -> some View {
        HStack {
            Text(task.name)
            Spacer()
            Text(createReadableDueDate(from: task.dueDate))
                .padding(.trailing)
            Text(task.priority.asString)
        }
        .padding()
    }
}

// MARK: - Helpers
private extension TaskListView {
    func createReadableDueDate(from dueDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: dueDate)
    }
}

#Preview {
    let viewModel = TaskListViewModel()
    return TaskListView(viewModel: viewModel)
}
