//
//  CoreDataStorage+Read.swift
//  Simple
//
//  Created by Mikael Weiss on 2/15/21.
//

import Foundation
import Persistence

extension CoreDataStorage: StorageReadable {
    
    // MARK: - Tasks
    
    func getTask(with id: UUID) throws -> Storage.Task? {
        guard let persistenceTask = try? store.getTask(with: id)
        else {
            throw StorageError.objectNotFound(id.uuidString)
        }
        return factory.task(from: persistenceTask)
    }
    
    func getAllTasks() throws -> [Storage.Task] {
        let storeTasks = try store.getAllTasks()
        return storeTasks.map { factory.task(from: $0) }
    }
}
