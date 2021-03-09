//
//  Frequency.swift
//  Simple
//
//  Created by Mikael Weiss on 3/5/21.
//

import Foundation

enum Frequency {
    case never
    case hourly(HourlyRecurrence)
    case daily(DailyRecurrence)
    case weekly(WeeklyRecurrence)
    case monthly(MonthlyRecurrence)
    case yearly(YearlyRecurrence)
}
