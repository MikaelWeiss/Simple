//
//  Frequency.swift
//  Simple
//
//  Created by Mikael Weiss on 3/5/21.
//

import Foundation

enum Frequency {
    case never
    case hourly
    case daily(Set<HourOfTheDay>)
    case weekly(Set<DayOfTheWeek>)
    case monthly(MonthlyRecurrence)
    case yearly(YearlyRecurrence)
    
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
            
            enum DayOfTheWeekOfTheMonth: Int {
                case sunday, monday, tuesday, wednesday, thursday, friday, saturday, day, weekday, weekendDay
            }
            
            enum WeekOfTheMonth: Int {
                case first, second, third, fourth, fifth, last
            }
        }
    }
    
    struct YearlyRecurrence {
        var monthsOfTheYear: Set<MonthOfTheYear>
        var dayOfTheMonth: MonthlyRecurrence
    }
}

enum MinutesOfTheHour {
    case one, two, three, four, five, six, seven, eight, nine, ten, eleven, twelve, thirteen, fourteen, fifteen, sixteen, seventeen, eighteen, nineteen, twenty, twentyone, twentytwo, twentythree, twentyfour, twentyfive, twentysix, twentyseven, twentyeight, twentynine, thirty, thirtyone, thirtytwo, thirtythree, thirtyfour, thirtyfive, thirtysix, thirtyseven, thirtyeight, thirtynine, fourty, fourtyone, fourtytwo, fourtythree, fourtyfour, fourtyfive, fourtysix, fourtyseven, fourtyeight, fourtynine, fifty, fiftyone, fiftytwo, fiftythree, fiftyfour, fiftyfive, fiftysix, fiftyseven, fiftyeight, fiftynine, sixty
}

enum HourOfTheDay {
    case one, two, three, four, five, six, seven, eight, nine, ten, eleven, twelve, thirteen, fourteen, fifteen, sixteen, seventeen, eighteen, nineteen, twenty, twentyone, twentytwo, twentythree
}

enum DayOfTheWeek {
    case sunday, monday, tuesday, wednesday, thursday, friday, saturday
}

enum DayOfTheMonth {
    case first, second, third, fourth, fifth, sixth, seventh, eighth, nineth, tenth, eleventh, twelveth, thirtineth, fourteenth, fifteenth, sixteenth, seventeenth, eighteenth, nineteenth, twentieth, twentyfirst, twentysecond, twentythird, twentyfourth, twentyfifth, twentysixth, twentyseventh, twentyeighth, twentynineth, thirtieth, thirtyfirst
}

enum MonthOfTheYear {
    case january, february, march, april, may, june, july, august, september, october, november, december
}
