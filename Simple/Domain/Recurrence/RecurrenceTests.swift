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
    
    func testDaily() {
        // Given
        let fiveDaysAgo = Date().adding(days: -5)
        let today = Date.today
        let recurrence = Recurrence(frequency: .daily)
        
        // When
        let shouldRecur = recurrence.shouldRecur(startDate: fiveDaysAgo, currentDate: today)
        
        // Then
        XCTAssertTrue(shouldRecur)
    }
    
    func testEveryThreeDays() {
        // Given
        let oneWeekAgo = Date().adding(days: -6)
        let today = Date.today
        let recurrence = Recurrence(frequency: .daily, interval: 3)
        
        // When
        let shouldRecur = recurrence.shouldRecur(startDate: oneWeekAgo, currentDate: today)
        
        // Then
        XCTAssertTrue(shouldRecur)
    }
    
    func testEveryThreeDaysNotGivenDay() {
        // Given
        let oneWeekAgo = Date().adding(days: -5)
        let today = Date.today
        let recurrence = Recurrence(frequency: .daily, interval: 3)
        
        // When
        let shouldRecur = recurrence.shouldRecur(startDate: oneWeekAgo, currentDate: today)
        
        // Then
        XCTAssertFalse(shouldRecur)
    }
    
    func testDateThing() {
        for i in Int16.min ... Int16.max {
            XCTAssertNotNil(Date().adding(days: i))
        }
    }
}
