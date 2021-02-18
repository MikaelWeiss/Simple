//
//  CoreDataStoreTests.swift
//  Persistence
//
//  Created by Mikael Weiss on 2/18/21.
//

@testable import Persistence
import XCTest

class CoreDataStoreTests: XCTestCase {
    
    var store: CoreDataStore!
    
    override func setUp() {
        super.setUp()
        store = CoreDataStore()
        try? store.deleteAll()
    }
    
    override func tearDown() {
        try? store.deleteAll()
        super.tearDown()
    }
    
    // MARK: - Save
    
    func testSaveNoChanges() {
        // Given
        
        // When
        XCTAssertNoThrow(try store.save())
        
        // Then
    }
    
    func testSaveHasChanges() {
        // Given
        _ = store.newTask()
        
        // When
        XCTAssertNoThrow(try store.save())
        
        // Then
    }
    
    // MARK: - Delete All
    
    func testDeleteAll() {
        // Given
        var result: Persistence.Task?
        let id = UUID()
        let newEntity = store.newTask()
        newEntity.id = id
        XCTAssertNoThrow(try store.save())
        
        // When
        XCTAssertNoThrow(try store.deleteAll())
        
        // Then
        XCTAssertNoThrow(result = try store.getTask(with: id))
        XCTAssertNil(result)
    }
}
