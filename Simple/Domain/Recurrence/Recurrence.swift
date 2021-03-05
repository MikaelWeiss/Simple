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
        self.frequency = frequency
        self.recurrenceEnd = recurrenceEnd
        self.interval = interval
    }
    
    init() {
        id = UUID()
        frequency = .daily(Frequency.DailyRecurrence(hoursOfTheDay: Set(arrayLiteral: .eight)))
        recurrenceEnd = .occurrenceCount(1)
        interval = Interval()
    }
    
    struct ReconstitutionInfo {
        
    }
    
    init(with: ReconstitutionInfo) {
        
    }
}
