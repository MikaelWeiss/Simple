//
//  Recurrence.swift
//  Simple
//
//  Created by Mikael Weiss on 3/4/21.
//

import Foundation


struct Recurrence {
    private(set) var id: UUID
    private(set) var frequency: Frequency
    private(set) var recurrenceEnd: RecurrenceEnd
    private(set) var interval: Int
    
    private(set) var weekdays: Set<DayOfTheWeek>
    private(set) var monthlyRecurrence: MonthlyRecurrence
    private(set) var monthsOfTheYear: Set<MonthsOfTheYear>
    
    private(set) var timeFrames: Set<TimeFrame>
    
    init(
        id: UUID = UUID(),
        frequency: Frequency = .never,
        recurrenceEnd: RecurrenceEnd = .rightAway,
        interval: Int = 1,
        daysOfTheWeek: Set<DayOfTheWeek> = [],
        monthlyRecurrence: MonthlyRecurrence = MonthlyRecurrence.daysOfTheMonth(Set<Int>()),
        monthsOfTheYear: Set<MonthsOfTheYear> = [],
        timeFrames: Set<TimeFrame> = [TimeFrame.defaultTimeFrame]
    ) {
        self.id = id
        self.frequency = frequency
        self.recurrenceEnd = recurrenceEnd
        self.interval = interval
        self.weekdays = daysOfTheWeek
        self.monthlyRecurrence = monthlyRecurrence
        self.monthsOfTheYear = monthsOfTheYear
        self.timeFrames = timeFrames
    }
    
    func shouldRecur(startDate: Date, currentDate: Date) -> Bool {
        let includedTimeFrames = timeFrames.filter { date(currentDate, isWithin: $0) }
        guard !includedTimeFrames.isEmpty else { return false }
        
        let weekday = currentDate.weekday
        let day = currentDate.day
        
        switch frequency {
        case .never: return false
        case .daily: return check(interval: interval, for: .daily, given: startDate, currentDate: currentDate)
        case .weekly:
            let intervalCheck = check(interval: interval, for: .weekly, given: startDate, currentDate: currentDate)
            if intervalCheck == false { return false }
            
            if weekdays.contains(where: { $0.rawValue == weekday }) { return true } else { return false }
        case .monthly:
            let intervalCheck = check(interval: interval, for: .monthly, given: startDate, currentDate: currentDate)
            if intervalCheck == false { return false }
            
            return checkMonthlyRecurrence(monthlyRecurrence, day: day, weekday: weekday, currentDate: currentDate)
        case .yearly:
            let intervalCheck = check(interval: interval, for: .yearly, given: startDate, currentDate: currentDate)
            if intervalCheck == false { return false }
            
            return checkMonthlyRecurrence(monthlyRecurrence, day: day, weekday: weekday, currentDate: currentDate)
        }
    }
    
    private func date(_ date: Date, isWithin timeFrame: TimeFrame) -> Bool {
        let hourAndMinute = Calendar.current.dateComponents([.hour, .minute], from: date)
        guard let hour = hourAndMinute.hour,
              let minute = hourAndMinute.minute
        else { return false }
        
        if hour < timeFrame.startHour || hour > timeFrame.endHour {
            return false
        } else if hour == timeFrame.startHour {
            if minute < timeFrame.startMinute {
               return false
            } else {
                return true
            }
        } else if hour == timeFrame.endHour {
            if minute > timeFrame.endMinute {
                return false
            } else {
                return true
            }
        } else {
            return true
        }
    }
    
    private func checkMonthlyRecurrence(_ monthlyRecurrence: MonthlyRecurrence, day: Int, weekday: Int, currentDate: Date) -> Bool {
        switch monthlyRecurrence {
        case .daysOfTheMonth(let daysOfTheMonth):
            if daysOfTheMonth.contains(day) { return true }
            else { return false }
        case .computedDayOfTheMonth(let computedDayOfTheMonth):
            
            guard ordinalityIsCorrect(computedDayOfTheMonth, currentDate) == true else { return false }
            
            return isDayOfTheWeek(given: computedDayOfTheMonth, weekday: weekday)
        }
    }
    
    private func ordinalityIsCorrect(_ computedDayOfTheMonth: MonthlyRecurrence.ComputedDayOfTheMonth, _ currentDate: Date) -> Bool {
        let ordinality = Calendar.current.ordinality(of: .weekday, in: .month, for: currentDate)
        
        switch computedDayOfTheMonth {
        case .first: return ordinality == 1
        case .second: return ordinality == 2
        case .third: return ordinality == 3
        case .fourth: return ordinality == 4
        case .fifth: return ordinality == 5
        case .last: return isLastWeekOfMonth(currentDate)
        }
    }
    
    private func isLastWeekOfMonth(_ date: Date) -> Bool {
        let nextWeek = date.adding(days: 7)
        
        if date.month == nextWeek.month {
            return true
        } else {
            return false
        }
    }
    
    private func isDayOfTheWeek(given computedDayOfTheMonth: MonthlyRecurrence.ComputedDayOfTheMonth, weekday: Int) -> Bool {
        switch computedDayOfTheMonth {
        case .first(let computedDayOfTheWeek):
            return isComputedDayOfTheWeek(given: computedDayOfTheWeek, weekday: weekday)
        case .second(let computedDayOfTheWeek):
            return isComputedDayOfTheWeek(given: computedDayOfTheWeek, weekday: weekday)
        case .third(let computedDayOfTheWeek):
            return isComputedDayOfTheWeek(given: computedDayOfTheWeek, weekday: weekday)
        case .fourth(let computedDayOfTheWeek):
            return isComputedDayOfTheWeek(given: computedDayOfTheWeek, weekday: weekday)
        case .fifth(let computedDayOfTheWeek):
            return isComputedDayOfTheWeek(given: computedDayOfTheWeek, weekday: weekday)
        case .last(let computedDayOfTheWeek):
            return isComputedDayOfTheWeek(given: computedDayOfTheWeek, weekday: weekday)
        }
    }
    
    private func isComputedDayOfTheWeek(given computedDayOfTheWeek: MonthlyRecurrence.ComputedDayOfTheWeek, weekday: Int) -> Bool {
        switch computedDayOfTheWeek {
        case .normalWeekday(let dayOfTheWeek):
            return dayOfTheWeek.rawValue == weekday
        case .day:
            return weekday == 1
        case .weekday:
            return weekday == 2
        case .weekendDay:
            return weekday == 6
        }
    }
    
    private func check(interval: Int, for frequency: Frequency, given startDate: Date, currentDate: Date) -> Bool {
        let cal = Calendar.current
        switch frequency {
        case .never: return false
        case .daily:
            let days = cal.interval(of: .day, from: startDate, to: currentDate)
            if (days % interval == 0) { return true } else { return false }
        case .weekly:
            let weeks = cal.interval(of: .day, from: startDate, to: currentDate) / 7
            if (weeks % interval == 0) { return true } else { return false }
        case .monthly:
            let months = cal.interval(of: .month, from: startDate, to: currentDate)
            if (months % interval == 0) { return true } else { return false }
        case .yearly:
            let years = cal.interval(of: .year, from: startDate, to: currentDate)
            if (years % interval == 0) { return true } else { return false }
        }
    }
}

enum DefaultRecurrence: CaseIterable {
    case never, daily, weekly, biweekly, monthly, everyThreeMonths, everySixMonths, yearly
}

extension Date {
    func adding(days: Int16) -> Date {
        let cal = Calendar.current
        let newDate = cal.date(byAdding: .day, value: Int(days), to: self)
        return newDate!
    }
    
    func adding(weeks: Int16) -> Date {
        let cal = Calendar.current
        let weeksInDays = weeks * 7
        let newDate = cal.date(byAdding: .day, value: Int(weeksInDays), to: self)
        return newDate!
    }
    
    func adding(months: Int16) -> Date {
        let cal = Calendar.current
        let newDate = cal.date(byAdding: .month, value: Int(months), to: self)
        return newDate!
    }
    
    static func oneWeekAgo() -> Date {
        Date().adding(days: -7)
    }
    
    var day: Int {
        let cal = Calendar.current
        let day = cal.component(.day, from: self)
        return day
    }
    
    var month: Int {
        let cal = Calendar.current
        let month = cal.component(.month, from: self)
        return month
    }
    
    var weekOfMonth: Int {
        let cal = Calendar.current
        let weekOfMonth = cal.component(.weekOfMonth, from: self)
        return weekOfMonth
    }
    
    var weekday: Int {
        let cal = Calendar.current
        let weekday = cal.component(.weekday, from: self)
        return weekday
    }
}

enum DayOfTheWeek: Int {
    case sunday = 1, monday, tuesday, wednesday, thursday, friday, saturday
}

enum MonthsOfTheYear: Int {
    case january = 1, february, march, april, may, june, july, august, september, october, november, december
}

extension Calendar {
    func interval(of unit: Calendar.Component, from startDate: Date, to endDate: Date) -> Int {
        let rangeOfStart = self.dateInterval(of: unit, for: startDate)!
        let rangeOfEnd = self.dateInterval(of: unit, for: endDate)!
        let startOfStart = rangeOfStart.start
        let endOfEnd = rangeOfEnd.end.addingTimeInterval(-1)
        let interval = self.dateComponents([unit], from: startOfStart, to: endOfEnd)
        return interval.value(for: unit) ?? 0
    }
}

extension DateFormatter {
    class var standard: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }
}

class InteractorSupport {
    static func sanitize(dateString: String) -> String {
        var sanitizedDateString = dateString
        
        let dateFormatter = DateFormatter()
        var date: Date?
        let formats = ["MM/dd/yyyy", "M/dd/yyyy", "MM/d/yyyy", "M/d/yyyy", "dd MMM yyyy"]
        for format in formats {
            dateFormatter.dateFormat = format
            if let parsedDate = dateFormatter.date(from: dateString) {
                date = parsedDate
                break
            }
        }
        
        if let parsedDate = date {
            sanitizedDateString = DateFormatter.standard.string(from: parsedDate)
        }
        
        return sanitizedDateString
    }
}

extension Date {
    init?(dateString: String) {
        let sanitized = InteractorSupport.sanitize(dateString: dateString)
        
        if let date = DateFormatter.standard.date(from: sanitized) {
            self = date
        } else {
            return nil
        }
    }
}
