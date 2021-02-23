//
//  StorageToDomainTransformerTests.swift
//  SimpleTests
//
//  Created by Mikael Weiss on 2/15/21.
//

import XCTest
@testable import Simple

class StorageToDomainTransformerTests: XCTestCase {
    
    var factory = StorageToDomainFactory()
    
    // MARK: - Task
    func testTask() throws {
        // Given
        let id = UUID()
        let givenDate = Date()
        let storageTask = Storage.Task(
            id: id,
            name: "Some task name",
            preferredTime: givenDate,
            frequency: "daily",
            imageData: UIImage(named: "testingImage")?.pngData())
        
        // When
        let task = try factory.task(from: storageTask)
        
        // Then
        XCTAssertEqual(task.id, id)
        XCTAssertEqual(task.name, "Some task name")
        XCTAssertEqual(task.preferredTime, givenDate)
        XCTAssertEqual(task.frequency, .daily)
        XCTAssertEqual(task.image?.pngData(), UIImage(named: "testingImage")?.pngData())
    }
}
