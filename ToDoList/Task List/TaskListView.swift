//
//  TaskListView.swift
//  ToDoList
//
//  Created by Vladislav Smelov on 10/20/24.
//

import SwiftUI

struct TaskListView: View {
    private enum ActionSheetOptions {
        case sort
        case filter
    }
    @State private var actionSheetPresented: Bool = false
    @State private var actionSheetOption: ActionSheetOptions = .sort

    @ObservedObject private(set) var viewModel: TaskListViewModel

    var body: some View {
        BaseNavigationView {
            taskList
        } toolBar: {
            ToolbarItem(placement: .topBarLeading) {
                addTaskButton
            }
            ToolbarItem(placement: .principal) {
                Text("To-Do List")
            }
            ToolbarItemGroup(placement: .topBarTrailing) {
                filterButton
                sortButton
            }
        }
        .actionSheet(isPresented: $actionSheetPresented) {
            switch actionSheetOption {
            case .sort:
                return sortingActionSheet
            case .filter:
                return filteringActionSheet
            }
        }
    }
}

// MARK: - ToolbarItems
private extension TaskListView {
    var addTaskButton: some View {
        Button {
            viewModel.run(action: .addTask)
        } label: {
            Image(systemName: "plus.circle")
        }
    }

    var sortButton: some View {
        Button {
            actionSheetOption = .sort
            actionSheetPresented.toggle()
        } label: {
            Image(systemName: "arrow.up.arrow.down")
        }
    }

    var sortingActionSheet: ActionSheet {
        var options = viewModel.allSortingOptions.map { option in
            ActionSheet.Button
                .default(Text(option.userFriendlyName)) {
                    viewModel.sort(by: option)
                }
        }
        options.append(ActionSheet.Button.cancel())
        return ActionSheet(
            title: Text("Sorting order"),
            buttons: options)
    }

    var filterButton: some View {
        Button {
            actionSheetOption = .filter
            actionSheetPresented.toggle()
        } label: {
            Image(systemName: "checkmark")
        }
    }

    var filteringActionSheet: ActionSheet {
        var options = viewModel.allFilteringOptions.map { option in
            ActionSheet.Button
                .default(Text(option.userFriendlyName)) {
                    viewModel.filter(by: option)
                }
        }
        options.append(ActionSheet.Button.cancel())
        return ActionSheet(
            title: Text("Sorting order"),
            buttons: options)
    }
}

// MARK: - Main content
private extension TaskListView {
    var taskList: some View {
        List {
            Section {
                ForEach(viewModel.tasksToDisplay, id: \.id) { task in
                    cell(for: task)
                }
                .onDelete(perform: viewModel.deleteTask)
            } header: {
                Text("All tasks")
            }
        }
    }

    func cell(for task: ToDoTask) -> some View {
        Button {
            // TODO: Edit
        } label: {
            VStack(alignment: .leading, spacing: 8) {
                Text(task.name)
                HStack {
                    Text(task.priority.asString)
                    Spacer()
                    Text(createReadableDueDate(from: task.dueDate))
                }
            }
            .padding(8)
        }
        .buttonStyle(.borderless)
    }
}

// MARK: - Helpers
private extension TaskListView {
    func createReadableDueDate(from dueDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: dueDate)
    }
}

#Preview {
    let viewModel = TaskListViewModel()
    return TaskListView(viewModel: viewModel)
}
