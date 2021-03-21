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
        timeFrames: Set<TimeFrame> = []
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
        guard frequency != .never else { return false }
        
        let includedTimeFrames = timeFrames.filter({ date(currentDate, isWithin: $0) })
        guard !includedTimeFrames.isEmpty else { return false }
        
        let dateComponents = Calendar.current.dateComponents([.weekday, .day, .weekOfMonth, .month], from: currentDate)
        guard let weekday = dateComponents.weekday,
              let day = dateComponents.day,
              let weekOfTheMonth = dateComponents.weekOfMonth,
              let month = dateComponents.month
        else { return false}
        
        switch frequency {
        case .never: return false
        case .daily: return true
        case .weekly:
            if weekdays.contains(weekday) { return true }
            else { return false }
        case .monthly:
            switch monthlyRecurrence {
            case .daysOfTheMonth(let daysOfTheMonth):
                if daysOfTheMonth.contains(day) { return true }
                else { return false }
            case .computedDayOfTheMonth(let computedDayOfTheMonth):
                if !isTheWeekOfTheMonth(currentWeek: weekOfTheMonth, computedWeek: computedDayOfTheMonth.weekOfTheMonth) {
                    return false
                }
                
                if isDayOfTheMonth(weekday: weekday, computedDayOfTheMonth: computedDayOfTheMonth) {
                    return true
                }
                return false
            }
        case .yearly:
            if !monthsOfTheYear.contains(month) { return false }
            
            switch monthlyRecurrence {
            case .daysOfTheMonth(let daysOfTheMonth):
                if daysOfTheMonth.contains(day) { return true }
                else { return false }
            case .computedDayOfTheMonth(let computedDayOfTheMonth):
                if !isTheWeekOfTheMonth(currentWeek: weekOfTheMonth, computedWeek: computedDayOfTheMonth.weekOfTheMonth) {
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
        }
        return false
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
    
    private func isTheWeekOfTheMonth(currentWeek: Int, computedWeek: MonthlyRecurrence.ComputedDayOfTheMonth.WeekOfTheMonth) -> Bool {
        switch computedWeek {
        case .ordinal(let week):
        if week == currentWeek { return true }
        case .last: if isLastWeekOfMonth(currentWeek) { return true }
        }
        return false
    }
    
    private func isLastWeekOfMonth(_ week: Int) -> Bool {
        week == 5 ? true : (week == 4)
    }
}

enum DefaultRecurrence: CaseIterable {
    case never, daily, weekly, biweekly, monthly, everyThreeMonths, everySixMonths, yearly
}
