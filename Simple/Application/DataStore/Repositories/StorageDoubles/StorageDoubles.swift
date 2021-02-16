//
//  StorageDoubles.swift
//  Simple
//
//  Created by Mikael Weiss on 2/15/21.
//

import Foundation
@testable import Simple

enum StorageType {
    case task
}

class StorageProviderDouble: StorageProvider {
    let storageRead: StorageReadable
    let storageWrite: StorageWritable
    
    init() {
        let storageReadWriteDouble = StorageReadWriteDouble()
        storageRead = storageReadWriteDouble
        storageWrite = storageReadWriteDouble
    }
    
    init(storageRead: StorageReadable, storageWrite: StorageWritable) {
        self.storageRead = storageRead
        self.storageWrite = storageWrite
    }
}

class StorageReadWriteDouble: StorageReadable, StorageWritable {
    
    private var storage = [StorageType: Any]()
    
    subscript<T>(key: StorageType) -> T? {
        get {
            return value(for: key)
        }
        set {
            set(value: newValue as Any, for: key)
        }
    }
    
    // MARK: - StorageReadable
    
    private func values<T>(for key: StorageType) -> [T] {
        if let array = storage[key] as? [T] {
            return array
        }
        return array(of: storage[key] as? T)
    }
    
    private func array<T>(of item: T?) -> [T] {
        return item.map { [$0] } ?? []
    }
    
    // MARK: Task
    
    func getTask(with id: UUID) throws -> Storage.Task? {
        value(for: .task)
    }
    
    func getAllTasks() throws -> [Storage.Task] {
        values(for: .task)
    }
    
    // MARK: - StorageWritable
    
    func set(value: Any, for key: StorageType) {
        storage[key] = value
    }
    
    func value<T>(for key: StorageType) -> T? {
        return storage[key] as? T
    }
    
    // MARK: Task
    
    func addTask(_ storageTask: Storage.Task) throws {
        set(value: storageTask, for: .task)
    }
    
    func updateTask(_ storageTask: Storage.Task) throws {
        storage[.task] = storageTask
    }
    
    func deleteTask(with id: UUID) throws {
        storage.removeValue(forKey: .task)
    }
}
