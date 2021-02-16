//
//  StorageReadable.swift
//  Simple
//
//  Created by Mikael Weiss on 2/15/21.
//

import Foundation

protocol StorageReadable {
    
    // MARK: - Tasks
    func getTask(with id: UUID) throws -> Storage.Task?
    func getAllTasks() throws -> [Storage.Task]
}
