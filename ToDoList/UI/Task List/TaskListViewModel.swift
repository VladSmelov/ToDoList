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
        case .fetch:
            fetchTasks()
        case .deleteTask(let indexSet):
            deleteTask(at: indexSet)
        case .sortBy(let sortingOption):
            sort(by: sortingOption)
        case .filterBy(let filteringOption):
            filter(by: filteringOption)
        default:
            break
        }
    }

    enum Action {
        case fetch
        case addTask
        case deleteTask(atIndex: IndexSet)
        case view(task: ToDoTask)
        case sortBy(_ sortingOption: ToDoTaskSortingOption)
        case filterBy(_ filteringOption: ToDoTaskFilteringOption)
    }
}

// MARK: - Data manipulation
private extension TaskListViewModel {
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

    func deleteTask(at indexSet: IndexSet) {
        let index = indexSet[indexSet.startIndex]
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
