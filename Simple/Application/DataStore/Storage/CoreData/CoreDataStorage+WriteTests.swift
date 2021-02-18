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
