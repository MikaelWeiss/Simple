//
//  WeeklyRecurrence.swift
//  Simple
//
//  Created by Mikael Weiss on 3/5/21.
//

import Foundation

struct WeeklyRecurrence {
    enum DayOfTheWeek: Int, CaseIterable {
        case sunday = 1, monday, tuesday, wednesday, thursday, friday, saturday
    }
    var daysOfTheWeek: Set<DayOfTheWeek>
}
