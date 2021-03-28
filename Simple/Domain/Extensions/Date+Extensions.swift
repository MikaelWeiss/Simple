//
//  Date+Extension.swift
//  Simple
//
//  Created by Mikael Weiss on 2/15/21.
//

import Foundation

extension Date {
    static var today: Date { // Sometimes this reads better
        return Date()
    }
    
    static var now: Date { // Sometimes this reads better
        return Date()
    }
    
    func adding(days: Int16) -> Date {
        let cal = Calendar.current
        let newDate = cal.date(byAdding: .day, value: Int(days), to: self)
        return newDate!
    }
    
    func adding(weeks: Int16) -> Date {
        let cal = Calendar.current
        let weeksInDays = weeks * 7
        let newDate = cal.date(byAdding: .day, value: Int(weeksInDays), to: self)
        return newDate!
    }
    
    func adding(months: Int16) -> Date {
        let cal = Calendar.current
        let newDate = cal.date(byAdding: .month, value: Int(months), to: self)
        return newDate!
    }
    
    static func oneWeekAgo() -> Date {
        Date().adding(days: -7)
    }
    
    var day: Int {
        let cal = Calendar.current
        let day = cal.component(.day, from: self)
        return day
    }
    
    var month: Int {
        let cal = Calendar.current
        let month = cal.component(.month, from: self)
        return month
    }
    
    var weekOfMonth: Int {
        let cal = Calendar.current
        let weekOfMonth = cal.component(.weekOfMonth, from: self)
        return weekOfMonth
    }
    
    var weekday: Int {
        let cal = Calendar.current
        let weekday = cal.component(.weekday, from: self)
        return weekday
    }
}
