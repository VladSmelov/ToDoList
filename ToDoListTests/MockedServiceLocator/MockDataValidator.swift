//
//  MockDataValidator.swift
//  ToDoListTests
//
//  Created by Vladislav Smelov on 10/21/24.
//

import Foundation
@testable import ToDoList

final class MockDataValidator: DataValidatorProtocol {
    var mockedError: Error?

    func validate(task: ToDoTask) throws {
        try throwErrorIfPresent()
    }

    private func throwErrorIfPresent() throws {
        guard let mockedError else { return }
        throw mockedError
    }
}
