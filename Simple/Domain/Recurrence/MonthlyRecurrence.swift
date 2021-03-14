//
//  MonthlyRecurrence.swift
//  Simple
//
//  Created by Mikael Weiss on 3/8/21.
//

import Foundation

enum MonthlyRecurrence {
    case daysOfTheMonth(Set<Int>)
    case computedDayOfTheMonth(ComputedDayOfTheMonth)
    
    struct ComputedDayOfTheMonth {
        let weekOfTheMonth: WeekOfTheMonth
        let dayOfTheWeekOfTheMonth: DayOfTheWeekOfTheMonth
        
        init(weekOfTheMonth: WeekOfTheMonth, dayOfTheWeekOfTheMonth: DayOfTheWeekOfTheMonth) {
            self.weekOfTheMonth = weekOfTheMonth
            self.dayOfTheWeekOfTheMonth = dayOfTheWeekOfTheMonth
        }
        
        enum DayOfTheWeekOfTheMonth {
            case sunday, monday, tuesday, wednesday, thursday, friday, saturday, day, weekday, weekendDay
        }
        
        enum WeekOfTheMonth {
            case first, second, third, fourth, fifth, last
        }
    }
}
