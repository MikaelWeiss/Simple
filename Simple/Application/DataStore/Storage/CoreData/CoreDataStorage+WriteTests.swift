//
//  CoreDataStorage+WriteTests.swift
//  SimpleTests
//
//  Created by Mikael Weiss on 2/17/21.
//

import XCTest
@testable import Simple
import Persistence

class CoreDataStorageWriteTests: XCTestCase {
    
    var store: CoreDataStore!
    var storage: CoreDataStorage!
    
    // MARK: - Tasks
    
    func testAddTask() throws {
        // Given
        let id = UUID()
        let date = Date.today
        let storageTask = makeStorageTask(
            id: id,
            name: "Some name",
            preferredTime: date,
            frequency: "daily",
            imageData: nil)
        
        // When
        try storage.addTask(storageTask)
        
        // Then
//        let storeTasks = try store.getAllTasks()
//        let storeTask = try store.getTask(with: id)
//        XCTAssertEqual(storeTask?.id, id)
//        XCTAssertEqual(storeTask?.name, "Some name")
//        XCTAssertEqual(storeTask?.preferredTime, date)
//        XCTAssertEqual(storeTask?.frequency, "daily")
//        XCTAssertEqual(storeTask?.imageData, nil)
//        XCTAssertEqual(storeTasks.count, 1)
    }
    
    func testUpdateTaskMissingID() {
        // Given
        let storageTask = makeStorageTask(id: nil)
        
        // When/Then
        XCTAssertThrowsError(try storage.updateTask(storageTask))
    }
    
    // MARK: - Helpers
    func makeStorageTask(
        id: UUID? = UUID(),
        name: String? = nil,
        preferredTime: Date? = nil,
        frequency: String? = nil,
        imageData: Data? = nil) -> Storage.Task {
        
        Storage.Task(id: id,
                     name: name,
                     preferredTime: preferredTime,
                     frequency: frequency,
                     imageData: imageData)
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
}
