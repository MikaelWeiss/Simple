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

enum DayOfTheWeek {
    case sunday, monday, tuesday, wednesday, thursday, friday, saturday
}
