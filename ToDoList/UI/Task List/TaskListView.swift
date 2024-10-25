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
                Text(Localized.title.value)
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
        .onAppear {
            viewModel.run(action: .fetch)
        }
    }
}

// MARK: - ToolbarItems
private extension TaskListView {
    var addTaskButton: some View {
        Button {
            viewModel.run(action: .addTask)
        } label: {
            Image(systemName: "plus")
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
                    viewModel.run(action: .sortBy(option))
                }
        }
        options.append(ActionSheet.Button.cancel())
        return ActionSheet(
            title: Text(Localized.sortingOrder.value),
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
                    viewModel.run(action: .filterBy(option))
                }
        }
        options.append(ActionSheet.Button.cancel())
        return ActionSheet(
            title: Text(Localized.filteringOrder.value),
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
                .onDelete { indexSet in
                    viewModel.run(action: .deleteTask(atIndex: indexSet))
                }
            } header: {
                Text(Localized.allTasks.value)
            }
        }
    }

    func cell(for task: ToDoTask) -> some View {
        Button {
            viewModel.run(action: .view(task: task))
        } label: {
            VStack(alignment: .leading, spacing: 8) {
                Text(task.name)
                HStack {
                    Text(task.priority.userFriendlyName)
                    Spacer()
                    Text(task.userFriendlyDueDate)
                }
            }
            .padding(8)
        }
        .buttonStyle(.borderless)
    }
}

private extension TaskListView {
    // Mock enum that can be used for localization
    enum Localized: String {
        case title = "To-Do List"
        case sortingOrder = "Sorting order"
        case filteringOrder = "Filtering order"
        case allTasks = "All tasks"
        case taskNamePlaceholder = "Enter Task name"
        case saveButtonTitle = "Save"

        var value: String {
            rawValue
        }
    }
}

#Preview {
    let viewModel = TaskListViewModel()
    return TaskListView(viewModel: viewModel)
}
