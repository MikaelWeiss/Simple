//
//  YearlyRecurrence.swift
//  Simple
//
//  Created by Mikael Weiss on 3/8/21.
//

import Foundation

struct YearlyRecurrence {
    var monthsOfTheYear: Set<MonthOfTheYear>
    var dayOfTheMonth: DayOfTheMonth
}

enum MonthOfTheYear: Int {
    case january = 1, february, march, april, may, june, july, august, september, october, november, december
}
