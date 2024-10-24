//
//  TaskListViewModel.swift
//  ToDoList
//
//  Created by Vladislav Smelov on 10/20/24.
//

import Foundation

class TaskListViewModel: ObservableObject {
    @Published private var tasks: [ToDoTask]
    @Published var tasksToDisplay: [ToDoTask]
    @Published private(set) var action: Action?
    private(set) var errorText: String?

    init() {
        tasks = []
        tasksToDisplay = []
    }
}

// MARK: - Actions
extension TaskListViewModel {
    func run(action: Action) {
        self.action = action
        
        switch action {
        case .sortBy(let sortingOption):
            sort(by: sortingOption)
        case .filterBy(let filteringOption):
            filter(by: filteringOption)
        default:
            break
        }
    }

    enum Action {
        case addTask
        case view(task: ToDoTask)
        case sortBy(_ sortingOption: ToDoTaskSortingOption)
        case filterBy(_ filteringOption: ToDoTaskFilteringOption)
    }
}

// MARK: - Data manipulation
extension TaskListViewModel {
    func fetchTasks() {
        do {
            let fetchUseCase = FetchTasksUseCase()
            let newList = try fetchUseCase.execute()

            tasks = newList.allTasks
            tasksToDisplay = newList.tasksToDisplay
        } catch {
            errorText = error.localizedDescription
        }
    }

    func deleteTask(at offsets: IndexSet) {
        let index = offsets[offsets.startIndex]
        let taskToDelete = tasksToDisplay[index]
        do {
            try DeleteTaskUseCase(taskToDelete: taskToDelete).execute()
            fetchTasks()
        } catch {
            errorText = error.localizedDescription
        }
    }
}

// MARK: - Sotring
extension TaskListViewModel {
    var allSortingOptions: [ToDoTaskSortingOption] {
        ToDoTaskSortingOption.allCases
    }

    private func sort(by sortingOption: ToDoTaskSortingOption) {
        let sortingUseCase = SortTasksUseCase(tasks: tasks, sortingOption: sortingOption)
        tasksToDisplay = sortingUseCase.execute()
    }
}

// MARK: - Filtering
extension TaskListViewModel {
    var allFilteringOptions: [ToDoTaskFilteringOption] {
        ToDoTaskFilteringOption.allCases
    }

    private func filter(by filteringOption: ToDoTaskFilteringOption) {
        let filteringUseCase = FilterTasksUseCase(tasks: tasks, filteringOption: filteringOption)
        tasksToDisplay = filteringUseCase.execute()
    }
}
