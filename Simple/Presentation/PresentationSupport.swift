//
//  PresentationSupport.swift
//  Simple
//
//  Created by Mikael Weiss on 3/6/21.
//
//
//import Foundation
//
//enum PresentationError: Error {
//    case unwrapFailed
//}
//
//enum PresentationSupport {
//    
//    // MARK: - Recurrence
//    
//    static func defaultRecurrence(_ recurrence: Recurrence.DefaultRecurrence, for date: Date) throws -> Recurrence {
//        switch recurrence {
//        case .never: return Recurrence(frequency: .never, recurrenceEnd: .occurrenceCount(1), interval: Interval())
//        case .hourly: return recurrenceFor(frequency: .hourly)
//        case .daily: return recurrenceFor(frequency: .daily(try dailyRecurrence(for: date)))
//        case .weekly: return recurrenceFor(frequency: .weekly(try weeklyRecurrence(for: date)))
//        case .biweekly: return Recurrence(frequency: .weekly(try weeklyRecurrence(for: date)), recurrenceEnd: .never, interval: try Interval(interval: 2))
//        case .monthly: return recurrenceFor(frequency: .monthly(try monthlyRecurrency(for: date)))
//        case .everyThreeMonths: return Recurrence(frequency: .monthly(try monthlyRecurrency(for: date)), recurrenceEnd: .never, interval: try Interval(interval: 3))
//        case .everySixMonths: return Recurrence(frequency: .monthly(try monthlyRecurrency(for: date)), recurrenceEnd: .never, interval: try Interval(interval: 6))
//        case .yearly: return recurrenceFor(frequency: .yearly(try yearlyRecurrence(for: date)))
//        }
//    }
//    
//    private static func recurrenceFor(frequency: Frequency) -> Recurrence {
//        Recurrence(frequency: frequency, recurrenceEnd: .never, interval: Interval())
//    }
//    
//    static func hourOfTheDay(date: Date = Date.now) throws -> DailyRecurrence.HoursOfTheDay {
//        let hour = Calendar.current.component(.hour, from: date)
//        guard let hoursOfTheDay =  DailyRecurrence.HoursOfTheDay.init(rawValue: hour) else { throw PresentationError.unwrapFailed }
//        return hoursOfTheDay
//    }
//    
//    private static func dailyRecurrence(for date: Date) throws -> DailyRecurrence {
//        let hourOfTheDaySet = Set(arrayLiteral: try hourOfTheDay())
//        return DailyRecurrence(hoursOfTheDay: hourOfTheDaySet)
//    }
//    
//    static func dayOfTheWeek(for date: Date = Date.now) throws -> WeeklyRecurrence.DayOfTheWeek {
//        let integerDayOfTheWeek = Calendar.current.component(.weekday, from: date)
//        guard let dayOfTheWeek = WeeklyRecurrence.DayOfTheWeek(rawValue: integerDayOfTheWeek) else { throw PresentationError.unwrapFailed }
//        return dayOfTheWeek
//    }
//    
//    private static func weeklyRecurrence(for date: Date) throws -> WeeklyRecurrence {
//        let dayOfTheWeekSet = Set(arrayLiteral: try dayOfTheWeek(for: date))
//        return WeeklyRecurrence(daysOfTheWeek: dayOfTheWeekSet)
//    }
//    
//    static func dayOfTheMonth(for date: Date = Date.now) throws -> MonthlyRecurrence.IntegerDayOfTheMonth {
//        let integerDayOfTheMonth = Calendar.current.component(.month, from: date)
//        guard let dayOfTheMonth = try? MonthlyRecurrence.IntegerDayOfTheMonth(dayOfTheMonth: integerDayOfTheMonth) else { throw PresentationError.unwrapFailed }
//        return dayOfTheMonth
//    }
//    
//    private static func monthlyRecurrency(for date: Date) throws -> MonthlyRecurrence {
//        let monthOfTheYear = MonthlyRecurrence.DayOfTheMonth.daysOfTheMonth(Set(arrayLiteral: try dayOfTheMonth(for: date)))
//        return MonthlyRecurrence(recurrence: monthOfTheYear)
//    }
//    
//    static func monthOfTheYear(for date: Date = Date.now) throws -> YearlyRecurrence.MonthOfTheYear {
//        let integerMonthOfTheYear = Calendar.current.component(.month, from: date)
//        guard let monthOfTheYear = YearlyRecurrence.MonthOfTheYear(rawValue: integerMonthOfTheYear) else { throw PresentationError.unwrapFailed }
//        return monthOfTheYear
//    }
//    
//    private static func yearlyRecurrence(for date: Date) throws -> YearlyRecurrence {
//        guard let dayOfTheMonth = try? monthlyRecurrency(for: date).recurrence else { throw PresentationError.unwrapFailed }
//        return YearlyRecurrence(monthsOfTheYear: Set(arrayLiteral: try monthOfTheYear(for: date)), dayOfTheMonth: dayOfTheMonth)
//    }
//    
//    // MARK: - Frequency
//    
//    static func string(for weeklyRecurrence: WeeklyRecurrence.DayOfTheWeek) -> String {
//        switch weeklyRecurrence {
//        case .sunday: return "Sunday"
//        case .monday: return "Monday"
//        case .tuesday: return "Tuesday"
//        case .wednesday: return "Wednesday"
//        case .thursday: return "Thursday"
//        case .friday: return "Friday"
//        case .saturday: return "Saturday"
//        }
//    }
//}
