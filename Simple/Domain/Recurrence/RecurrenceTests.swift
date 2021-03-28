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
        let sixDaysAgo = Date().adding(days: -6)
        let today = Date.today
        let recurrence = Recurrence(frequency: .daily, interval: 3)
        
        // When
        let shouldRecur = recurrence.shouldRecur(startDate: sixDaysAgo, currentDate: today)
        
        // Then
        XCTAssertTrue(shouldRecur)
    }
    
    func testEveryThreeDaysNotGivenDay() {
        // Given
        let fiveDaysAgo = Date().adding(days: -5)
        let today = Date.today
        let recurrence = Recurrence(frequency: .daily, interval: 3)
        
        // When
        let shouldRecur = recurrence.shouldRecur(startDate: fiveDaysAgo, currentDate: today)
        
        // Then
        XCTAssertFalse(shouldRecur)
    }
    
    func testWeeklyOnMonday() {
        // Given
        let cal = Calendar.current
        let today = cal.date(bySetting: .weekday, value: 2, of: Date.today)!
        let oneWeekAgo = today.adding(days: -7)
        let recurrence = Recurrence(frequency: .weekly, daysOfTheWeek: [.monday])
        
        // When
        let shouldRecur = recurrence.shouldRecur(startDate: oneWeekAgo, currentDate: today)
        
        // Then
        XCTAssertTrue(shouldRecur)
    }
    
    func testWeeklyOnMultipleDays() {
        // Given
        let cal = Calendar.current
        let today = cal.date(bySetting: .weekday, value: 5, of: Date.today)!
        let oneWeekAgo = today.adding(days: -7)
        let recurrence = Recurrence(frequency: .weekly, daysOfTheWeek: [.monday, .thursday, .friday])
        
        // When
        let shouldRecur = recurrence.shouldRecur(startDate: oneWeekAgo, currentDate: today)
        
        // Then
        XCTAssertTrue(shouldRecur)
    }
    
    func testMonthyOnTheFirst() {
        // Given
        let cal = Calendar.current
        let today = cal.date(bySetting: .day, value: 1, of: Date.today)!
        let oneWeekAgo = today.adding(days: -7)
//        let recurrence = Recurrence(frequency: .monthly, daysOfTheWeek: [.monday, .thursday, .friday])
        let recurrence = Recurrence(frequency: .monthly, monthlyRecurrence: .daysOfTheMonth([1]))
        
        // When
        let shouldRecur = recurrence.shouldRecur(startDate: oneWeekAgo, currentDate: today)
        
        // Then
        XCTAssertTrue(shouldRecur)
    }
    
    func testMonthyOnTheFirstFalse() {
        // Given
        let cal = Calendar.current
        let today = cal.date(bySetting: .day, value: 5, of: Date.today)!
        let oneWeekAgo = today.adding(days: -7)
        let recurrence = Recurrence(frequency: .monthly, monthlyRecurrence: .daysOfTheMonth([1]))
        
        // When
        let shouldRecur = recurrence.shouldRecur(startDate: oneWeekAgo, currentDate: today)
        
        // Then
        XCTAssertFalse(shouldRecur)
    }
    
    func testMonthyOnTheFirstWithInterval() {
        // Given
        let today = Date(dateString: "04/01/2020")!
        let twoMonthsAgo = today.adding(months: -3)
        let recurrence = Recurrence(frequency: .monthly, interval: 3, monthlyRecurrence: .daysOfTheMonth([1]))
        
        // When
        let shouldRecur = recurrence.shouldRecur(startDate: twoMonthsAgo, currentDate: today)
        
        // Then
        XCTAssertTrue(shouldRecur)
    }
    
    func testMonthyOnTheFirstWithIntervalFalse() {
        // Given
        let cal = Calendar.current
        let components = DateComponents(month: 4, day: 1)
        let today = cal.date(from: components)!
        let twoMonthsAgo = today.adding(months: -2)
        let recurrence = Recurrence(frequency: .monthly, interval: 3, monthlyRecurrence: .daysOfTheMonth([1]))
        
        // When
        let shouldRecur = recurrence.shouldRecur(startDate: twoMonthsAgo, currentDate: today)
        
        // Then
        XCTAssertFalse(shouldRecur)
    }
    
    func testMonthlyFirstSunday() {
        // Given
        let today = Date(dateString: "01/03/2021")!
        let twoMonthsAgo = today.adding(months: -2)
        let recurrence = Recurrence(frequency: .monthly, monthlyRecurrence: .computedDayOfTheMonth(.first(.normalWeekday(.sunday))))
        
        // When
        let shouldRecur = recurrence.shouldRecur(startDate: twoMonthsAgo, currentDate: today)
        
        // Then
        XCTAssertTrue(shouldRecur)
    }
    
    func testMonthlyFirstSundayFalse() {
        // Given
        let cal = Calendar.current
        let components = DateComponents(month: 4)
        let today = cal.date(from: components)!
        let twoMonthsAgo = today.adding(months: -2)
        let recurrence = Recurrence(frequency: .monthly, monthlyRecurrence: .computedDayOfTheMonth(.first(.normalWeekday(.sunday))))
        
        // When
        let shouldRecur = recurrence.shouldRecur(startDate: twoMonthsAgo, currentDate: today)
        
        // Then
        XCTAssertFalse(shouldRecur)
    }
}
