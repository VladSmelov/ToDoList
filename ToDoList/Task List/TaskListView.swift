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
        ScrollView {
            taskList
        }
    }
}

// MARK: - Sub Views
private extension TaskListView {
    var taskList: some View {
        ForEach(viewModel.tasks, id: \.id) { task in
            cell(for: task)
        }
        .frame(maxWidth: .infinity)
    }

    func cell(for task: Task) -> some View {
        VStack {
            HStack {
                Text(task.name)
                Spacer()
                Text(createReadableDueDate(from: task.dueDate))
                    .padding(.trailing)
                Text(task.priority.asString)
            }
            .padding()

            Divider()
                .padding(.horizontal)
        }
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
