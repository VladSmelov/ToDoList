//
//  AddTaskView.swift
//  ToDoList
//
//  Created by Vladislav Smelov on 10/20/24.
//

import SwiftUI

struct AddTaskView: View {
    @ObservedObject private(set) var viewModel: AddTaskViewModel

    var body: some View {
        BaseNavigationView {
            Text("Add task here")
        } toolBar: {
            ToolbarItem(placement: .navigation) {
                backArrow
            }
            ToolbarItem(placement: .principal) {
                Text("To-Do List")
            }
        }
    }
}

// MARK: - Sub Views
private extension AddTaskView {
    var backArrow: some View {
        Button {
            viewModel.run(action: .goBack)
        } label: {
            Image(systemName: "chevron.backward")
        }
    }


}

#Preview {
    AddTaskView(viewModel: .init())
}
