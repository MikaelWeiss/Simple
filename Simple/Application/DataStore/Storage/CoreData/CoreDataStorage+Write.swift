//
//  CoreDataStorage+Write.swift
//  Simple
//
//  Created by Mikael Weiss on 2/15/21.
//

import Foundation
import Persistence

extension CoreDataStorage: StorageWritable {
    
    // MARK: - Tasks
    
    func addTask(_ storageTask: Storage.Task) throws {
        let storeTask = store.newTask()
        factory.copyTaskValues(from: storageTask, to: storeTask)
        try store.save()
    }
    
    func updateTask(_ storageTask: Storage.Task) throws {
        guard let taskID = storageTask.id else {
            throw StorageError.missingID
        }
        
        guard let storeTask = try store.getTask(with: taskID) else {
            throw StorageError.objectNotFound(taskID.uuidString)
        }
        
        factory.copyTaskValues(from: storageTask, to: storeTask)
        try store.save()
    }
    
    func deleteTask(with id: UUID) throws {
        try store.deleteTask(with: id)
        try store.save()
    }
}
