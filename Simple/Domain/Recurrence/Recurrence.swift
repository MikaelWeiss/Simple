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
}
