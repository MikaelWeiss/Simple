//
//  PresentationSupport.swift
//  Simple
//
//  Created by Mikael Weiss on 3/6/21.
//

import Foundation

enum PresentationError: Error {
    case unwrapFailed
}

enum PresentationSupport {
    
    // MARK: - Recurrence
    
    func defaultRecurrence(_ recurrence: Recurrence.DefaultRecurrence, for date: Date) throws -> Recurrence {
        switch recurrence {
        case .never: return Recurrence(frequency: .never, recurrenceEnd: .occurrenceCount(1), interval: Interval())
        case .hourly: return recurrenceFor(frequency: .hourly)
        case .daily: return recurrenceFor(frequency: .daily(try dailyRecurrence(for: date)))
        case .weekly: return recurrenceFor(frequency: .weekly(try weeklyRecurrence(for: date)))
        case .biweekly: return Recurrence(frequency: .weekly(try weeklyRecurrence(for: date)), recurrenceEnd: .never, interval: try Interval(interval: 2))
        case .monthly: return recurrenceFor(frequency: .monthly(try monthlyRecurrency(for: date)))
        case .everyThreeMonths: return Recurrence(frequency: .monthly(try monthlyRecurrency(for: date)), recurrenceEnd: .never, interval: try Interval(interval: 3))
        case .everySixMonths: return Recurrence(frequency: .monthly(try monthlyRecurrency(for: date)), recurrenceEnd: .never, interval: try Interval(interval: 6))
        case .yearly: return recurrenceFor(frequency: .yearly(try yearlyRecurrence(for: date)))
        }
    }
    
    private func recurrenceFor(frequency: Frequency) -> Recurrence {
        Recurrence(frequency: frequency, recurrenceEnd: .never, interval: Interval())
    }
    
    private func dailyRecurrence(for date: Date) throws -> DailyRecurrence {
        let hour = Calendar.current.component(.hour, from: date)
        guard let hoursOfTheDay =  DailyRecurrence.HoursOfTheDay.init(rawValue: hour) else { throw PresentationError.unwrapFailed }
        let hourOfTheDay = Set(arrayLiteral: hoursOfTheDay)
        return DailyRecurrence(hoursOfTheDay: hourOfTheDay)
    }
    
    private func weeklyRecurrence(for date: Date) throws -> WeeklyRecurrence {
        let integerDayOfTheWeek = Calendar.current.component(.weekday, from: date)
        guard let dayOfTheWeek = WeeklyRecurrence.DayOfTheWeek(rawValue: integerDayOfTheWeek) else { throw PresentationError.unwrapFailed }
        let dayOfTheWeekSet = Set(arrayLiteral: dayOfTheWeek)
        return WeeklyRecurrence(daysOfTheWeek: dayOfTheWeekSet)
    }
    
    private func monthlyRecurrency(for date: Date) throws -> MonthlyRecurrence {
        let integerDayOfTheMonth = Calendar.current.component(.month, from: date)
        guard let dayOfTheMonth = try? MonthlyRecurrence.IntegerDayOfTheMonth(dayOfTheMonth: integerDayOfTheMonth) else { throw PresentationError.unwrapFailed }
        let monthOfTheYear = MonthlyRecurrence.DayOfTheMonth.daysOfTheMonth(Set(arrayLiteral: dayOfTheMonth))
        return MonthlyRecurrence(recurrence: monthOfTheYear)
    }
    
    private func yearlyRecurrence(for date: Date) throws -> YearlyRecurrence {
        let integerMonthOfTheYear = Calendar.current.component(.month, from: date)
        guard let monthOfTheYear = YearlyRecurrence.MonthOfTheYear(rawValue: integerMonthOfTheYear) else { throw PresentationError.unwrapFailed }
        guard let dayOfTheMonth = try? monthlyRecurrency(for: date).recurrence else { throw PresentationError.unwrapFailed }
        return YearlyRecurrence(monthsOfTheYear: Set(arrayLiteral: monthOfTheYear), dayOfTheMonth: dayOfTheMonth)
    }
    
}
