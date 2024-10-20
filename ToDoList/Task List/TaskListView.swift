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
            ForEach(viewModel.tasks, id: \.id) { task in
                Text(task.name)
            }
        }
    }
}

#Preview {
    let viewModel = TaskListViewModel()
    return TaskListView(viewModel: viewModel)
}
