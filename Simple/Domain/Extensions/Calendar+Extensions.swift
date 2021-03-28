//
//  Calendar+Extensions.swift
//  Simple
//
//  Created by Mikael Weiss on 3/27/21.
//

import Foundation

extension Calendar {
    func interval(of unit: Calendar.Component, from startDate: Date, to endDate: Date) -> Int {
        let rangeOfStart = self.dateInterval(of: unit, for: startDate)!
        let rangeOfEnd = self.dateInterval(of: unit, for: endDate)!
        let startOfStart = rangeOfStart.start
        let endOfEnd = rangeOfEnd.end.addingTimeInterval(-1)
        let interval = self.dateComponents([unit], from: startOfStart, to: endOfEnd)
        return interval.value(for: unit) ?? 0
    }
}
