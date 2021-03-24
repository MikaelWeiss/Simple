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
    
    private(set) var weekdays: Set<Int>
    private(set) var monthlyRecurrence: MonthlyRecurrence
    private(set) var monthsOfTheYear: Set<Int>
    
    private(set) var timeFrames: Set<TimeFrame>
    
    init(
        id: UUID = UUID(),
        frequency: Frequency = .never,
        recurrenceEnd: RecurrenceEnd = .rightAway,
        interval: Int = 1,
        daysOfTheWeek: Set<Int> = [],
        monthlyRecurrence: MonthlyRecurrence = MonthlyRecurrence.daysOfTheMonth(Set<Int>()),
        monthsOfTheYear: Set<Int> = [],
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
        
        let dateComponents = Calendar.current.dateComponents([.weekday, .day, .month], from: currentDate)
        guard let weekday = dateComponents.weekday,
              let day = dateComponents.day,
              let month = dateComponents.month
        else { return false }
        
        switch frequency {
        case .never: return false
        case .daily: return check(interval: interval, for: .daily, given: startDate, currentDate: currentDate)
        case .weekly:
            let intervalCheck = check(interval: interval, for: .weekly, given: startDate, currentDate: currentDate)
            if intervalCheck == false { return false }
            
            if weekdays.contains(weekday) { return true }
            else { return false }
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
            
            if !monthsOfTheYear.contains(month) { return false }
            
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
            return dayOfTheWeek == weekday
        case .day:
            return weekday == 2
        case .weekday:
            return weekday == 2
        case .weekendDay:
            return weekday == 6
        }
    }
    
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
        switch frequency {
        case .never: return false
        case .daily:
            let days = Date.intervalOf(component: .day, from: startDate, to: currentDate)
            if (days % interval == 0) { return true } else { return false }
        case .weekly:
            let weeks = Date.intervalOf(component: .day, from: startDate, to: currentDate) / 7
            if (weeks % interval == 0) { return true } else { return false }
        case .monthly:
            let months = Date.intervalOf(component: .month, from: startDate, to: currentDate)
            if (months % interval == 0) { return true } else { return false }
        case .yearly:
            let years = Date.intervalOf(component: .year, from: startDate, to: currentDate)
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
        let day = cal.date(byAdding: .day, value: Int(days), to: self)
        return day!
    }
    
    func subtracting(days: UInt16) -> Date {
        let cal = Calendar.current
        let day = cal.date(byAdding: .day, value: Int(days), to: self)!
        return day
    }
    
    static func oneWeekAgo() -> Date {
        Date().adding(days: 7)
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
    
    static func intervalOf(component: Calendar.Component, from startDate: Date, to endDate: Date) -> Int {
        let cal = Calendar.current
        let startDate = cal.startOfDay(for: startDate)
        let endDate = cal.startOfDay(for: endDate)
        
        guard let start = cal.ordinality(of: component, in: .era, for: startDate) else { return 0 }
        guard let end = cal.ordinality(of: component, in: .era, for: endDate) else { return 0 }
        
        return end - start
    }
}
