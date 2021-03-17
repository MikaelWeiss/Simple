//
//  CoreDataStoreStorageFactoryTests.swift
//  SimpleTests
//
//  Created by Mikael Weiss on 2/15/21.
//

import XCTest
@testable import Simple
import Persistence

class CoreDataStoreStorageFactoryTests: XCTestCase {
    
    var factory = CoreDataStoreStorageFactory()
    var store = CoreDataStore(storageType: .inMemory)
    
    func testTask() {
        // Given
        let preferredTimeDate = Date.now
        
        let storeTask = store.newTask()
        storeTask.id = UUID(uuidString: "123E4567-E89B-12D3-A456-426655440000")
        storeTask.name = "Some Task Name"
        storeTask.preferredTime = preferredTimeDate
        storeTask.frequency = "Some frequency"
        storeTask.imageData = Data(base64Encoded: "Some data")
        
        // When
        let storageTask = factory.task(from: storeTask)
        
        XCTAssertEqual(storageTask.id, UUID(uuidString: "123E4567-E89B-12D3-A456-426655440000"))
        XCTAssertEqual(storageTask.name, "Some Task Name")
        XCTAssertEqual(storageTask.preferredTime, preferredTimeDate)
        XCTAssertEqual(storageTask.imageData, Data(base64Encoded: "Some data"))
    }
}
