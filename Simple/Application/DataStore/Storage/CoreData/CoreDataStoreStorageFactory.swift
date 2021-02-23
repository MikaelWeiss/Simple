//
//  CoreDataStorageFactory.swift
//  Simple
//
//  Created by Mikael Weiss on 2/15/21.
//

import Foundation
import Persistence

protocol CoreDataStoreStorage {
    // Core Data Store -> Storage
    func task(from storeTask: Persistence.Task) -> Storage.Task
    
    // Storage -> Core Data Store
    // The store does the actual creation. We just copy values here.
    func copyTaskValues(from task: Storage.Task, to storeTask: Persistence.Task)
}

class CoreDataStoreStorageFactory: CoreDataStoreStorage {
    // MARK: - Core Data Store - Storage
    
    func task(from storeTask: Persistence.Task) -> Storage.Task {
        Storage.Task(
            id: storeTask.id,
            name: storeTask.name,
            preferredTime: storeTask.preferredTime,
            frequency: storeTask.frequency,
            imageData: storeTask.imageData)
    }
    
    // MARK: - Storage -> Core Data Store
    func copyTaskValues(from task: Storage.Task, to storeTask: Persistence.Task) {
        storeTask.id = task.id
        storeTask.name = task.name
        storeTask.preferredTime = task.preferredTime
        storeTask.frequency = task.frequency
        storeTask.imageData = task.imageData
    }
}
