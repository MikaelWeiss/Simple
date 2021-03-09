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
    
    init(id: UUID = UUID(), frequency: Frequency, recurrenceEnd: RecurrenceEnd, interval: Int) {
        self.id = id
        self.frequency = frequency
        self.recurrenceEnd = recurrenceEnd
        self.interval = interval
    }
}
