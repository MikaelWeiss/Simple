//
//  TaskRepositoryTests.swift
//  SimpleTests
//
//  Created by Mikael Weiss on 2/15/21.
//

import XCTest
@testable import Simple

class TaskRepositoryTests: XCTestCase {
    
    var repository: TaskRepository!
    var storageRead: StorageReadable!
    var storageWrite: StorageWritable!
    var toDomain: StorageToDomainTransformer!
    var toStorage: DomainToStorageTransformer!
    
    func testFetchAllTasks() throws {
        
    }
    
    func makeStoreTask() -> Storage.Task {
        
    }
    
    // MARK: - Setup
    override func setUp() {
        super.setUp()
        toDomain = StorageToDomainFactory()
        toStorage = DomainToStorageFactory()
        storageRead = StorageReadWriteDouble()
        storageWrite = StorageReadWriteDouble()
        let storageProvider = StorageProviderDouble(storageRead: storageRead, storageWrite: storageWrite)
        repository = MainTaskRepository(
            storageProvider: storageProvider,
            toDomainTransformer: toDomain,
            toStorageTransformer: toStorage)
    }
}
