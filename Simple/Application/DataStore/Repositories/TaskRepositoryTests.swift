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
    var storageRead: StorageReadWriteDouble!
    var storageWrite: StorageReadWriteDouble!
    var toDomain: StorageToDomainTransformer!
    var toStorage: DomainToStorageTransformer!
    
    func testFetchAllTasks() throws {
        // Given
        let id = UUID()
        let time = Date.now
        storageRead[.task] = makeStoreTask(id: id, name: "Do something cool", time: time)
        
        // When
        let allTasks = try? repository.allTasks()
        
        // Then
        let task = allTasks?.first
        XCTAssertEqual(task?.id, id)
        XCTAssertEqual(task?.name, "Do something cool")
        XCTAssertEqual(task?.preferredTime, time)
        XCTAssertEqual(allTasks?.count, 1)
    }
    
    func testFetchTask() throws {
        // Given
        let id = UUID()
        storageRead[.task] = makeStoreTask(id: id, name: "Do something else")
        
        // When
        let task = try? repository.task(withID: id)
        
        // Then
        XCTAssertEqual(task?.id, id)
        XCTAssertEqual(task?.name, "Do something else")
    }
    
    func testAddTask() throws {
        // Given
        let id = UUID()
        let task = makeTask(id: id, frequency: .monthly)
        
        // When
        try repository.addTask(task)
        
        // Then
        let storeTask: Storage.Task? = storageWrite.value(for: .task)
        XCTAssertEqual(storeTask?.id, id)
        XCTAssertEqual(storeTask?.frequency, "monthly")
    }
    
    func testUpdateTask() throws {
        // Given
        let id = UUID()
        storageWrite[.task] = makeStoreTask(id: id, name: "asdf")
        let task = makeTask(id: id, name: "Some new name")
        
        // When
        try repository.updateTask(task)
        
        // Then
        let storeTask: Storage.Task? = storageWrite.value(for: .task)
        XCTAssertEqual(storeTask?.id, id)
        XCTAssertEqual(storeTask?.name, "Some new name")
    }
    
    func testDeleteTask() throws {
        // Given
        let id = UUID()
        storageWrite[.task] = makeStoreTask(id: id)
        
        // When
        try repository.deleteTask(id)
        
        // Then
        let storageTask: Storage.Task? = storageWrite.value(for: .task)
        XCTAssertNil(storageTask)
    }
    
    func makeStoreTask(id: UUID = UUID(), name: String = "some name", time: Date = Date()) -> Storage.Task {
        Storage.Task(id: id,
                     name: name,
                     preferredTime: time,
                     frequency: nil,
                     imageData: nil)
    }
    
    func makeTask(id: UUID, name: String = "", frequency: Frequency = .weekly) -> Task {
        Task(id: id, name: name, preferredTime: Date.now, frequency: frequency, image: nil)
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
