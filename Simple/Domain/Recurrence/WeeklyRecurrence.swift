//
//  WeeklyRecurrence.swift
//  Simple
//
//  Created by Mikael Weiss on 3/5/21.
//

import Foundation

struct WeeklyRecurrence {
    enum DayOfTheWeek {
        case sunday, monday, tuesday, wednesday, thursday, friday, saturday
    }
    var daysOfTheWeek: Set<DayOfTheWeek>
}
