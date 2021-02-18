//
//  CoreDataStorage+ReadTests.swift
//  SimpleTests
//
//  Created by Mikael Weiss on 2/17/21.
//

import XCTest
@testable import Simple
import Persistence

class CoreDataStorageReadTests: XCTestCase {
    
    var store: CoreDataStore!
    var storage: CoreDataStorage!
    
    // MARK: - Task
    
    func testGetTask() throws {
        // Given
        let id = UUID()
        let task = store.newTask()
        task.id = id
        
        // When
        let storageTask = try storage.getTask(with: id)
        
        // Then
        XCTAssertEqual(storageTask?.id, id)
    }
    
    func testGetAllTask() throws {
        // Given
        _ = store.newTask()
        _ = store.newTask()
        _ = store.newTask()
        
        // When
        let storageTasks = try store.getAllTasks()
        
        // Then
        XCTAssertEqual(storageTasks.count, 3)
    }
    
    // MARK: - setUp / tearDown
    
    override func setUp() {
        super.setUp()
        store = CoreDataStore()
        storage = CoreDataStorage(store: store)
        try? store.deleteAll()
    }
    
    override func tearDown() {
        try? store.deleteAll()
        super.tearDown()
    }
    
    // MARK: - Helpers
}
