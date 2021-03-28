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
    
    enum ComputedDayOfTheMonth {
        case first(ComputedDayOfTheWeek)
        case second(ComputedDayOfTheWeek)
        case third(ComputedDayOfTheWeek)
        case fourth(ComputedDayOfTheWeek)
        case fifth(ComputedDayOfTheWeek)
        case last(ComputedDayOfTheWeek)
    }
    
    enum ComputedDayOfTheWeek {
        case normalWeekday(DayOfTheWeek), day, weekday, weekendDay
    }
}
