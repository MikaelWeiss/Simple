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
    
    private(set) var daysOfTheWeek: Set<Int>
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
        self.daysOfTheWeek = daysOfTheWeek
        self.monthlyRecurrence = monthlyRecurrence
        self.monthsOfTheYear = monthsOfTheYear
        self.timeFrames = timeFrames
    }
    
    func shouldRecur(startDate: Date, currentDate: Date) -> Bool {
        let includedTimeFrames = timeFrames.filter({ date(currentDate, isWithin: $0) })
        guard !includedTimeFrames.isEmpty else { return false }
        return true
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
}

enum DefaultRecurrence: CaseIterable {
    case never, hourly, daily, weekly, biweekly, monthly, everyThreeMonths, everySixMonths, yearly
}
