//
//  MonthlyRecurrence.swift
//  Simple
//
//  Created by Mikael Weiss on 3/5/21.
//

import Foundation

struct MonthlyRecurrence {
    private(set) var recurrence: DayOfTheMonth
    mutating func set(recurrence: DayOfTheMonth) throws {
        self.recurrence = recurrence
    }
    
    // MARK: - Init
    
    init(recurrence: DayOfTheMonth) {
        self.recurrence = recurrence
    }
    
    // MARK: - Reconstitution
    
    struct ReconstitutionInfo {
        let recurrence: DayOfTheMonth.ReconstitutionInfo
    }
}

extension MonthlyRecurrence {
    enum DayOfTheMonth {
        case daysOfTheMonth(Set<IntegerDayOfTheMonth>)
        case computedDayOfTheMonth(ComputedDayOfTheMonth)
        
        struct ReconstitutionInfo {
            let daysOfTheMonth: [IntegerDayOfTheMonth.ReconstitutionInfo]?
            let computedDayOfTheMonth: ComputedDayOfTheMonth.ReconstitutionInfo?
        }
        
        init(with info: ReconstitutionInfo) throws {
            switch (info.daysOfTheMonth, info.computedDayOfTheMonth) {
            case (.some(let daysOfTheMonth), nil):
                let mappedDays = try daysOfTheMonth.map { try IntegerDayOfTheMonth(with: $0) }
                self = .daysOfTheMonth(Set(mappedDays))
            case (nil, .some(let computedDayOfTheMonth)):
                self = .computedDayOfTheMonth(try ComputedDayOfTheMonth(with: computedDayOfTheMonth))
            default: throw ReconstitutionError.invalidOption("Failed")
            }
        }
    }
}

// MARK: - Computed Day Of The Month
extension MonthlyRecurrence {
    
    struct ComputedDayOfTheMonth {
        
        private(set) var weekOfTheMonth: WeekOfTheMonth
        mutating func set(weekOfTheMonth: WeekOfTheMonth) throws {
            self.weekOfTheMonth = weekOfTheMonth
        }
        
        private(set) var dayOfTheMonth: ComputedDaysOfTheMonth
        mutating func set(dayOfTheMonth: ComputedDaysOfTheMonth) throws {
            self.dayOfTheMonth = dayOfTheMonth
        }
        
        // MARK: Init
        init(weekOfTheMonth: WeekOfTheMonth, dayOfTheMonth: ComputedDaysOfTheMonth) {
            self.weekOfTheMonth = weekOfTheMonth
            self.dayOfTheMonth = dayOfTheMonth
        }
        
        // MARK: Reconstitution
        struct ReconstitutionInfo {
            let weekOfTheMonth: WeekOfTheMonth.ReconstitutionInfo
            let dayOfTheMonth: ComputedDaysOfTheMonth.ReconstitutionInfo
        }
        
        init(with info: ReconstitutionInfo) throws {
            self.weekOfTheMonth = try WeekOfTheMonth(with: info.weekOfTheMonth)
            self.dayOfTheMonth = try ComputedDaysOfTheMonth(with: info.dayOfTheMonth)
        }
    }
}

// MARK: - Computed Days Of The Month

extension MonthlyRecurrence.ComputedDayOfTheMonth {
    
    enum ComputedDaysOfTheMonth: Int {
        case day
        case weekday
        case weekendDay
        
        // MARK: Reconstitution
        struct ReconstitutionInfo {
            let value: Int
        }
        
        init(with info: ReconstitutionInfo) throws {
            guard let val = ComputedDaysOfTheMonth(rawValue: info.value) else { throw ReconstitutionError.invalidOption("No String match: \(info.value)") }
            self = val
        }
    }
}

// MARK: - WeeksOfTheMonth

extension MonthlyRecurrence.ComputedDayOfTheMonth {
    
    enum WeekOfTheMonth: Int {
        case first, second, third, fourth, fifth, last
        
        // MARK: Reconstitution
        struct ReconstitutionInfo {
            let value: Int
        }
        
        init(with info: ReconstitutionInfo) throws {
            guard let val = WeekOfTheMonth(rawValue: info.value) else { throw ReconstitutionError.invalidOption("No String match: \(info.value)") }
            self = val
        }
    }
}

// MARK: - Integer Day Of The Month

extension MonthlyRecurrence {
    
    struct IntegerDayOfTheMonth: Hashable {
        
        private(set) var dayOfTheMonth: Int
        mutating func set(dayOfTheMonth: Int) throws {
            try this(error: DomainError.setFailed) {
                self.dayOfTheMonth = try dayOfTheMonth.residesInRange(min: 0, max: 24)
            }
        }
        
        // MARK: init
        init(dayOfTheMonth: Int) throws {
            do {
                self.dayOfTheMonth = try dayOfTheMonth.residesInRange(min: 0, max: 24)
            } catch {
                throw DomainError.initFailed
            }
        }
        
        // MARK: Reconstitution
        struct ReconstitutionInfo {
            let dayOfTheMonth: Int
        }
        
        init(with info: ReconstitutionInfo) throws {
            do {
                self.dayOfTheMonth = try info.dayOfTheMonth.residesInRange(min: 0, max: 24)
            } catch {
                throw ReconstitutionError.invalidOption("Outside of range: \(info.dayOfTheMonth)")
            }
        }
    }
}
