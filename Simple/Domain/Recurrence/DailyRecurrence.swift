//
//  DailyRecurrence.swift
//  Simple
//
//  Created by Mikael Weiss on 3/8/21.
//

import Foundation

struct DailyRecurrence {
    let hoursOfTheDay: Set<HourOfTheDay>
}

enum HourOfTheDay {
    case one, two, three, four, five, six, seven, eight, nine, ten, eleven, twelve, thirteen, fourteen, fifteen, sixteen, seventeen, eighteen, nineteen, twenty, twentyone, twentytwo, twentythree
}
