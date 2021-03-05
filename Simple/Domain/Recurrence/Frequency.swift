//
//  Frequency.swift
//  Simple
//
//  Created by Mikael Weiss on 3/5/21.
//

import Foundation

enum Frequency {
    case hourly
    case daily(DailyRecurrence)
    case weekly(WeeklyRecurrence)
    case monthly(MonthlyRecurrence)
    case yearly(YearlyRecurrence)
    
    struct ReconstitutionInfo {
        
    }
}
