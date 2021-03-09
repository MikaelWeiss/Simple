//
//  MonthlyRecurrence.swift
//  Simple
//
//  Created by Mikael Weiss on 3/8/21.
//

import Foundation

enum MonthlyRecurrence {
    case daysOfTheMonth(Set<DayOfTheMonth>)
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

enum DayOfTheMonth {
    case first, second, third, fourth, fifth, sixth, seventh, eighth, nineth, tenth, eleventh, twelveth, thirtineth, fourteenth, fifteenth, sixteenth, seventeenth, eighteenth, nineteenth, twentieth, twentyfirst, twentysecond, twentythird, twentyfourth, twentyfifth, twentysixth, twentyseventh, twentyeighth, twentynineth, thirtieth, thirtyfirst
}
