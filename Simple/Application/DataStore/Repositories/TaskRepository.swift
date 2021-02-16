//
//  TaskRepository.swift
//  Simple
//
//  Created by Mikael Weiss on 2/15/21.
//

import Foundation

protocol TaskRepository {
    func allTasks() throws -> [Task]
    func task(withID: UUID) throws -> Task?
    
    func addTask(_ task: Task) throws
    
    func updateTask(_ task: Task) throws
    func deleteTask(_ id: UUID) throws
}


class MainTaskRepository: TaskRepository {
    
    private let storageProvider: StorageProvider
    private let toDomain: StorageToDomainTransformer
    private let toStorage: DomainToStorageTransformer
    
    init(storageProvider: StorageProvider = MainStorageProvider.shared,
         toDomainTransformer: StorageToDomainTransformer = StorageToDomainFactory(),
         toStorageTransformer: DomainToStorageTransformer = DomainToStorageFactory()) {
        
        self.storageProvider = storageProvider
        self.toDomain = toDomainTransformer
        self.toStorage = toStorageTransformer
    }
    
    func allTasks() throws -> [Task] {
        guard let allTasks = try? storageProvider.storageRead.getAllTasks() else { return [] }
        return allTasks.compactMap { try? toDomain.task(from: $0) }
    }
    
    func task(withID: UUID) throws -> Task? {
        guard let storageTask = try storageProvider.storageRead.getTask(with: withID) else { return nil }
        return try toDomain.task(from: storageTask)
    }
    
    func addTask(_ task: Task) throws {
        let storageTask = toStorage.task(from: task)
        try storageProvider.storageWrite.addTask(storageTask)
    }
    
    func updateTask(_ task: Task) throws {
        let storageTask = toStorage.task(from: task)
        try storageProvider.storageWrite.updateTask(storageTask)
    }
    
    func deleteTask(_ id: UUID) throws {
        try storageProvider.storageWrite.deleteTask(with: id)
    }
}
