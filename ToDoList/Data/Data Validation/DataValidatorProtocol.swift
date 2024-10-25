//
//  DataValidatorProtocol.swift
//  ToDoList
//
//  Created by Vladislav Smelov on 10/21/24.
//

import Foundation

protocol DataValidatorProtocol {
    func validate(task: ToDoTask) throws
}
