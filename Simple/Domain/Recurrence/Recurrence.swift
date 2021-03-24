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
        let month = currentDate.month
        
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
            
            switch monthlyRecurrence {
            case .daysOfTheMonth(let daysOfTheMonth):
                if daysOfTheMonth.contains(day) { return true }
                else { return false }
            case .computedDayOfTheMonth(let computedDayOfTheMonth):
                if !isTheWeekOfTheMonth(currentWeek: currentDate, computedWeek: computedDayOfTheMonth.weekOfTheMonth) {
                    return false
                }
                
                if isDayOfTheMonth(weekday: weekday, computedDayOfTheMonth: computedDayOfTheMonth) {
                    return true
                }
                return false
            }
        case .yearly:
            let intervalCheck = check(interval: interval, for: .yearly, given: startDate, currentDate: currentDate)
            if intervalCheck == false { return false }
            
            if !monthsOfTheYear.contains(where: { $0.rawValue == month }) { return false }
            
            switch monthlyRecurrence {
            case .daysOfTheMonth(let daysOfTheMonth):
                if daysOfTheMonth.contains(day) { return true }
                else { return false }
            case .computedDayOfTheMonth(let computedDayOfTheMonth):
                if !isTheWeekOfTheMonth(currentWeek: currentDate, computedWeek: computedDayOfTheMonth.weekOfTheMonth) {
                    return false
                }
                
                if isDayOfTheMonth(weekday: weekday, computedDayOfTheMonth: computedDayOfTheMonth) {
                    return true
                }
                return false
            }
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
    
    private func isDayOfTheMonth(weekday: Int, computedDayOfTheMonth: MonthlyRecurrence.ComputedDayOfTheMonth) -> Bool {
        switch computedDayOfTheMonth.dayOfTheWeekOfTheMonth {
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
    
    // This fails most months because the first sunday of the month is not the first week of the month
    private func isTheWeekOfTheMonth(currentWeek: Date, computedWeek: MonthlyRecurrence.ComputedDayOfTheMonth.WeekOfTheMonth) -> Bool {
        switch computedWeek {
        case .ordinal(let week):
            if week == currentWeek.weekOfMonth { return true }
        case .last: if isLastWeekOfMonth(currentWeek) { return true }
        }
        return false
    }
    
    private func isLastWeekOfMonth(_ date: Date) -> Bool {
        let nextWeek = date.adding(days: 7)
        
        if date.month == nextWeek.month {
            return true
        } else {
            return false
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
