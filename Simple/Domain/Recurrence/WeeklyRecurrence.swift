//
//  WeeklyRecurrence.swift
//  Simple
//
//  Created by Mikael Weiss on 3/8/21.
//

import Foundation

struct WeeklyRecurrence {
    let daysOfTheWeek: Set<DayOfTheWeek>
}

enum DayOfTheWeek: Int {
    case sunday = 1, monday, tuesday, wednesday, thursday, friday, saturday
}
