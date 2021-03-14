//
//  RecurrenceTests.swift
//  SimpleTests
//
//  Created by Mikael Weiss on 3/6/21.
//

@testable import Simple
import XCTest

class RecurrenceTests: XCTestCase {
    
    func testNeverRepeate() {
        _ = Recurrence(frequency: .never, recurrenceEnd: .occurrenceCount(1), interval: 1)
    }
    
    func testFirstSundayOfEachMonth() {
    }
    
    func testFourthDayOfEachMonthEndingAfterSixTimesWithIntervalOfThree() {
    }
    
    func testMealRepetition() {
    }
}
