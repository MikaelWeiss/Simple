//
//  TimeFrame.swift
//  Simple
//
//  Created by Mikael Weiss on 3/20/21.
//

import Foundation

struct TimeFrame: Hashable {
    var startHour: Int
    var startMinute: Int
    var endHour: Int
    var endMinute: Int
}

extension TimeFrame {
    static var defaultTimeFrame: TimeFrame {
        TimeFrame(startHour: 0, startMinute: 0, endHour: 23, endMinute: 59)
    }
}
