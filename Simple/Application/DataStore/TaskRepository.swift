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
    
    func updateTask(_ taskID: UUID) throws
    func deleteTask(_ taskID: UUID) throws
}


class MainTaskRepository: TaskRepository {
    
    private let storageProvider: StorageProvider
    private let toDomain: StorageToDomainTransformer
    private let toStorage: DomainToStorageTransformer
    
    init(
        storageProvider: StorageProvider = ApplicationState.shared.userStorageProvider,
        toDomainTransformer: StorageToDomainTransformer = StorageToDomainFactory(),
        toStorageTransformer: DomainToStorageTransformer = DomainToStorageFactory()) {
        
        self.storageProvider = storageProvider
        self.toDomain = toDomainTransformer
        self.toStorage = toStorageTransformer
    }
    
    func allTasks() throws -> [Task] {
    }
    
    func task(withID: UUID) throws -> Task? {
    }
    
    func addTask(_ task: Task) throws {
    }
    
    func updateTask(_ taskID: UUID) throws {
    }
    
    func deleteTask(_ taskID: UUID) throws {
    }
}
