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
    mutating func set(frequency: Frequency) throws {
        self.frequency = frequency
    }
    
    private(set) var recurrenceEnd: RecurrenceEnd
    mutating func set(recurrenceEnd: RecurrenceEnd) {
        self.recurrenceEnd = recurrenceEnd
    }
    
    private(set) var interval: Interval
    mutating func set(interval: Interval) throws {
        self.interval = interval
    }
    
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
