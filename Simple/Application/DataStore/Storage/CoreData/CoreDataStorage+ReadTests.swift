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
//        let userID = UUID(uuidString: "123E4567-E89B-12D3-A456-426655440000")!
//        let user = makeUser(id: userID, firstName: "Gus", lastName: "Dentist")
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
