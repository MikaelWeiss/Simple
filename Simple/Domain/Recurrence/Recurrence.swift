//
//  Recurrence.swift
//  Simple
//
//  Created by Mikael Weiss on 3/4/21.
//

import Foundation


struct Recurrence {
    var id: UUID
    var frequency: Frequency
    var recurrenceEnd: RecurrenceEnd
    var interval: Interval
    
    init(id: UUID = UUID(), frequency: Frequency, recurrenceEnd: RecurrenceEnd, interval: Interval) {
        self.id = id
        self.frequency = frequency
        self.recurrenceEnd = recurrenceEnd
        self.interval = interval
    }
    
    init() {
        id = UUID()
        frequency = .daily(DailyRecurrence(hoursOfTheDay: Set(arrayLiteral: .eight)))
        recurrenceEnd = .occurrenceCount(1)
        interval = try! Interval()
    }
    
//    struct ReconstitutionInfo {
//
//    }
//
//    init(with: ReconstitutionInfo) {
//
//    }
}
