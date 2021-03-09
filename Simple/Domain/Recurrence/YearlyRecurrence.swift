//
//  YearlyRecurrence.swift
//  Simple
//
//  Created by Mikael Weiss on 3/8/21.
//

import Foundation

struct YearlyRecurrence {
    var monthsOfTheYear: Set<MonthOfTheYear>
    var dayOfTheMonth: MonthlyRecurrence
}

enum MonthOfTheYear {
    case january, february, march, april, may, june, july, august, september, october, november, december
}
