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
        _ = Recurrence(frequency: .monthly(.computedDayOfTheMonth(.init(weekOfTheMonth: .first, dayOfTheWeekOfTheMonth: .sunday))), recurrenceEnd: .never, interval: 1)
    }
    
    func testFourthDayOfEachMonthEndingAfterSixTimesWithIntervalOfThree() {
        _ = Recurrence(frequency: .monthly(.daysOfTheMonth([.fourth])), recurrenceEnd: .occurrenceCount(6), interval: 3)
    }
    
    func testMealRepetition() {
        _ = Recurrence(frequency: .daily(DailyRecurrence(hoursOfTheDay: [.eight, .twelve, .five])), recurrenceEnd: .never, interval: 1)
    }
}
