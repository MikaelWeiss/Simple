//
//  DailyRecurrence.swift
//  Simple
//
//  Created by Mikael Weiss on 3/5/21.
//

import Foundation

struct DailyRecurrence {
    enum HoursOfTheDay: Int {
        case one = 1, two, three, four, five, six, seven, eight, nine, ten, eleven, twelve, thirteen, fourteen, fifteen, sixteen, seventeen, eighteen, nineteen, twenty, twentyone, twentytwo, twentythree
    }
    
    private(set) var hoursOfTheDay: Set<HoursOfTheDay>
    mutating func set(hoursOfTheDay: Set<HoursOfTheDay>) throws {
        self.hoursOfTheDay = hoursOfTheDay
    }
    
    // MARK: - Initilization
    
    init(hoursOfTheDay: Set<HoursOfTheDay>) {
        self.hoursOfTheDay = hoursOfTheDay
    }
    
    // MARK: - Reconstitution
    
    struct ReconstitutionInfo {
        let hours: [Int]
    }
    
    init(with info: ReconstitutionInfo) throws {
        var hours = Set<HoursOfTheDay>()
        for val in info.hours {
            if let hour = HoursOfTheDay(rawValue: val) {
                hours.update(with: hour)
            } else {
                throw ReconstitutionError.invalidOption(String(val))
            }
        }
        if hours.count < 1 {
            throw ReconstitutionError.missingRequiredFields
        }
        hoursOfTheDay = hours
    }
}
