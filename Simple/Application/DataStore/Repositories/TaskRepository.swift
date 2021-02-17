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

protocol TaskRepositoryReadable {
    func getTask(with id: UUID) throws -> Storage.Task?
    func getAllTasks() throws -> [Storage.Task]
}
protocol TaskRepositoryWritable {
    func addTask(_ storageTask: Storage.Task) throws
    func updateTask(_ storageTask: Storage.Task) throws
    func deleteTask(with id: UUID) throws
}

class MainTaskRepository: TaskRepository {
    
    private let storageRead: TaskRepositoryReadable
    private let storageWrite: TaskRepositoryWritable
    private let toDomain: StorageToDomainTransformer
    private let toStorage: DomainToStorageTransformer
    
    init(storageRead: TaskRepositoryReadable,
         storageWrite: TaskRepositoryWritable,
         toDomainTransformer: StorageToDomainTransformer = StorageToDomainFactory(),
         toStorageTransformer: DomainToStorageTransformer = DomainToStorageFactory()) {
        
        self.storageRead = storageRead
        self.storageWrite = storageWrite
        self.toDomain = toDomainTransformer
        self.toStorage = toStorageTransformer
    }
    
    func allTasks() throws -> [Task] {
        guard let allTasks = try? storageRead.getAllTasks() else { return [] }
        return allTasks.compactMap { try? toDomain.task(from: $0) }
    }
    
    func task(withID: UUID) throws -> Task? {
        guard let storageTask = try storageRead.getTask(with: withID) else { return nil }
        return try toDomain.task(from: storageTask)
    }
    
    func addTask(_ task: Task) throws {
        let storageTask = toStorage.task(from: task)
        try storageWrite.addTask(storageTask)
    }
    
    func updateTask(_ task: Task) throws {
        let storageTask = toStorage.task(from: task)
        try storageWrite.updateTask(storageTask)
    }
    
    func deleteTask(_ id: UUID) throws {
        try storageWrite.deleteTask(with: id)
    }
}
