//
//  RecurrenceFactory.swift
//  Simple
//
//  Created by Mikael Weiss on 3/12/21.
//

import Foundation
import OSLog

struct RecurrenceFactory {
    
    enum FactoryError: Error {
        case initWithRawValueFailed
    }
    
    func defaultRecurrence(_ recurrence: DefaultRecurrence) -> Recurrence {
        switch recurrence {
        case .never: return Recurrence(frequency: .never, recurrenceEnd: .rightAway)
        case .daily: return neverEndingRecurrence(for: .daily)
        case .weekly: return neverEndingRecurrence(for: .weekly)
        case .biweekly: return neverEndingRecurrence(for: .weekly, interval: 2)
        case .monthly: return neverEndingRecurrence(for: .monthly)
        case .everyThreeMonths: return neverEndingRecurrence(for: .monthly, interval: 3)
        case .everySixMonths: return neverEndingRecurrence(for: .monthly, interval: 6)
        case .yearly: return neverEndingRecurrence(for: .yearly)
        }
    }
    
    private func neverEndingRecurrence(for frequency: Frequency, interval: Int = 1) -> Recurrence {
        Recurrence(frequency: frequency, recurrenceEnd: .never, interval: interval)
    }
}
