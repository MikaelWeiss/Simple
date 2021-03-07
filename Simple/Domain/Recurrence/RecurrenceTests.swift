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
        _ = Recurrence(frequency: Frequency.never, recurrenceEnd: .occurrenceCount(1), interval: Interval())
    }
    
    func testFirstSundayOfEachMonth() {
        _ = Recurrence(
            frequency: .monthly(MonthlyRecurrence(recurrence: .computedDayOfTheMonth(.init(weekOfTheMonth: .first, dayOfTheMonth: .sunday)))),
            recurrenceEnd: .never,
            interval: Interval())
    }
    
    func testFourthDayOfEachMonthEndingAfterFiveTimesWithIntervalOfFive() {
        _ = Recurrence(
            frequency: .monthly(MonthlyRecurrence(recurrence: .daysOfTheMonth(Set(arrayLiteral: try! MonthlyRecurrence.IntegerDayOfTheMonth(dayOfTheMonth: 4))))),
            recurrenceEnd: RecurrenceEnd.occurrenceCount(5),
            interval: try! Interval(interval: 5))
    }
    
    func testMealRepetition() {
        _ = Recurrence(
            frequency: .daily(DailyRecurrence(hoursOfTheDay: Set(arrayLiteral: DailyRecurrence.HoursOfTheDay.eight))),
            recurrenceEnd: .never,
            interval: try! Interval(interval: 1))
    }
}
