//
//  RecurrenceFactory.swift
//  Simple
//
//  Created by Mikael Weiss on 3/12/21.
//

import Foundation
import OSLog

struct RecurrenceFactory {
    
    enum FactoryError: Error {
        case initWithRawValueFailed
    }
    
    func defaultRecurrence(_ recurrence: DefaultRecurrence, for date: Date) throws -> Recurrence {
        switch recurrence {
        case .never: return Recurrence(frequency: .never, recurrenceEnd: .occurrenceCount(1), interval: 1)
        case .hourly: return recurrenceFor(frequency: .hourly(try hourlyRecurrence(for: date)))
        case .daily: return recurrenceFor(frequency: .daily(try dailyRecurrence(for: date)))
        case .weekly: return recurrenceFor(frequency: .weekly(try weeklyRecurrence(for: date)))
        case .biweekly: return Recurrence(frequency: .weekly(try weeklyRecurrence(for: date)), recurrenceEnd: .never, interval: 2)
        case .monthly: return recurrenceFor(frequency: .monthly(try monthlyRecurrency(for: date)))
        case .everyThreeMonths: return Recurrence(frequency: .monthly(try monthlyRecurrency(for: date)), recurrenceEnd: .never, interval: 3)
        case .everySixMonths: return Recurrence(frequency: .monthly(try monthlyRecurrency(for: date)), recurrenceEnd: .never, interval: 6)
        case .yearly: return recurrenceFor(frequency: .yearly(try yearlyRecurrence(for: date)))
        }
    }
    
    private func recurrenceFor(frequency: Frequency) -> Recurrence {
        Recurrence(frequency: frequency, recurrenceEnd: .never, interval: 1)
    }
    
    // MARK: Hourly Recurrence
    
    private func hourlyRecurrence(for date: Date) throws -> HourlyRecurrence {
        guard let minuteOfTheHour = minuteOfTheHour(for: date) else { throw FactoryError.initWithRawValueFailed }
        let minuteOfTheHourSet: Set<MinuteOfTheHour> = [minuteOfTheHour]
        return HourlyRecurrence(minutesOfTheHour: minuteOfTheHourSet)
    }
    
    private func minuteOfTheHour(for date: Date) -> MinuteOfTheHour? {
        let minute = Calendar.current.component(.minute, from: date)
        guard let minuteOfTheHour = MinuteOfTheHour.init(rawValue: minute) else { return nil }
        return minuteOfTheHour
    }
    
    // MARK: Daily Recurrence
    
    private func dailyRecurrence(for date: Date) throws -> DailyRecurrence {
        let hourOfTheDayVal = try hourOfTheDay(for: date)
        let hourOfTheDaySet: Set<HourOfTheDay> = [hourOfTheDayVal]
        return DailyRecurrence(hoursOfTheDay: hourOfTheDaySet)
    }
    
    private func hourOfTheDay(for date: Date) throws -> HourOfTheDay {
        let hour = Calendar.current.component(.hour, from: date)
        guard let hoursOfTheDay =  HourOfTheDay.init(rawValue: hour) else { throw FactoryError.initWithRawValueFailed }
        return hoursOfTheDay
    }
    
    // MARK: Weekly Recurrence
    
    private func weeklyRecurrence(for date: Date) throws -> WeeklyRecurrence {
        let dayOfTheWeekSet: Set<DayOfTheWeek> = [try dayOfTheWeek(for: date)]
        return WeeklyRecurrence(daysOfTheWeek: dayOfTheWeekSet)
    }
    
    private func dayOfTheWeek(for date: Date) throws -> DayOfTheWeek {
        let integerDayOfTheWeek = Calendar.current.component(.weekday, from: date)
        guard let dayOfTheWeek = DayOfTheWeek(rawValue: integerDayOfTheWeek) else { throw FactoryError.initWithRawValueFailed }
        return dayOfTheWeek
    }
    
    // MARK: Monthly Recurrence
    
    private func monthlyRecurrency(for date: Date) throws -> MonthlyRecurrence {
        let monthOfTheYear = try dayOfTheMonth(for: date)
        return MonthlyRecurrence.daysOfTheMonth([monthOfTheYear])
    }
    
    private func dayOfTheMonth(for date: Date) throws -> DayOfTheMonth {
        let integerDayOfTheMonth = Calendar.current.component(.month, from: date)
        guard let dayOfTheMonth = DayOfTheMonth(rawValue: integerDayOfTheMonth) else { throw FactoryError.initWithRawValueFailed }
        return dayOfTheMonth
    }
    
    // MARK: Yearly Recurrence
    
    private func yearlyRecurrence(for date: Date) throws -> YearlyRecurrence {
        let dayOfTheMonthVal = try dayOfTheMonth(for: date)
        return YearlyRecurrence(monthsOfTheYear: [try monthOfTheYear(for: date)], dayOfTheMonth: dayOfTheMonthVal)
    }
    
    private func monthOfTheYear(for date: Date) throws -> MonthOfTheYear {
        let integerMonthOfTheYear = Calendar.current.component(.month, from: date)
        guard let monthOfTheYear = MonthOfTheYear(rawValue: integerMonthOfTheYear) else { throw FactoryError.initWithRawValueFailed }
        return monthOfTheYear
    }
}
