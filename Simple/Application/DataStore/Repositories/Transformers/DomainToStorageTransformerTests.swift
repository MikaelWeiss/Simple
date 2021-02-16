//
//  DomainToStorageTransformerTests.swift
//  SimpleTests
//
//  Created by Mikael Weiss on 2/15/21.
//

import XCTest
@testable import Simple

class DomainToStorageTransformerTests: XCTestCase {
    
    var factory = DomainToStorageFactory()
    
    // MARK: - Task
    
    func testTask() {
        // Given
        let id = UUID()
        let date = Date.now
        let image = UIImage(named: "testingImage")!
        let domainTask = Task(id: id,
                        name: "Some name",
                        preferredTime: date,
                        frequency: Frequency.weekly,
                        image: image)
        
        // When
        let task = factory.task(from: domainTask)
        
        // Then
        XCTAssertEqual(task.id, id)
        XCTAssertEqual(task.name, "Some name")
        XCTAssertEqual(task.preferredTime, date)
        XCTAssertEqual(task.frequency, "weekly")
        XCTAssertEqual(task.imageData, image.pngData())
    }
}
