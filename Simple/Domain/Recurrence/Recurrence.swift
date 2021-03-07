//
//  Recurrence.swift
//  Simple
//
//  Created by Mikael Weiss on 3/4/21.
//

import Foundation


struct Recurrence {
    private(set) var id: UUID
    private(set) var timeframe: Timeframe
    private(set) var frequency: Frequency
    private(set) var recurrenceEnd: RecurrenceEnd
    private(set) var interval: Int
    
    init(id: UUID = UUID(), frequency: Frequency, timeframe: Timeframe, recurrenceEnd: RecurrenceEnd, interval: Int) {
        self.id = id
        self.frequency = frequency
        self.timeframe = timeframe
        self.recurrenceEnd = recurrenceEnd
        self.interval = interval
    }
    
    init() {
        id = UUID()
        frequency = .daily([.eight])
        timeframe = Timeframe.none
        recurrenceEnd = .occurrenceCount(1)
        interval = 1
    }
}

enum RecurrenceEnd {
    case date(Date)
    case occurrenceCount(Int)
    case never
}

extension Recurrence {
    enum DefaultRecurrence: CaseIterable {
        case never, hourly, daily, weekly, biweekly, monthly, everyThreeMonths, everySixMonths, yearly
    }
}

enum Timeframe {
    // From 3-5 PM repeate this task 5 times
    // From January-February repeat this task on the third day of every week
    
    case none
    case hour(start: MinutesOfTheHour, finish: MinutesOfTheHour)
    case day(start: HourOfTheDay, finish: HourOfTheDay)
    case week(start: DayOfTheWeek, finish: DayOfTheWeek)
    case month(start: DayOfTheMonth, finish: DayOfTheMonth)
    case year(start: MonthOfTheYear, finish: MonthOfTheYear)
}
