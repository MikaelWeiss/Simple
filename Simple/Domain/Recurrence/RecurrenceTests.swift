//
//  RecurrenceTests.swift
//  SimpleTests
//
//  Created by Mikael Weiss on 3/6/21.
//

import XCTest
@testable import Simple

class RecurrenceTests: XCTestCase {
    
    func testShouldRecurNever() {
        // Given
        let recurrence = Recurrence(frequency: .never)
        
        // When
        let shouldRecur = recurrence.shouldRecur(startDate: Date.now, currentDate: Date.now)
        
        // Then
        XCTAssertFalse(shouldRecur)
    }
}
