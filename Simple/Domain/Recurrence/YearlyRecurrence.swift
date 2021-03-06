//
//  YearlyRecurrence.swift
//  Simple
//
//  Created by Mikael Weiss on 3/5/21.
//

import Foundation

struct YearlyRecurrence {
    enum MonthOfTheYear: Int {
        case january = 1, february, march, april, may, june, july, august, september, october, november, december
    }
    var monthsOfTheYear: Set<MonthOfTheYear>
    var dayOfTheMonth: MonthlyRecurrence.DayOfTheMonth
}