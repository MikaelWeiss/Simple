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
        
        var stringValue: String {
            switch self {
            case .one: return "one"
            case .two: return "two"
            case .three: return "three"
            case .four: return "four"
            case .five: return "five"
            case .six: return "six"
            case .seven: return "seven"
            case .eight: return "eight"
            case .nine: return "nine"
            case .ten: return "ten"
            case .eleven: return "eleven"
            case .twelve: return "twelve"
            case .thirteen: return "thirteen"
            case .fourteen: return "fourteen"
            case .fifteen: return "fifteen"
            case .sixteen: return "sixteen"
            case .seventeen: return "seventeen"
            case .eighteen: return "eighteen"
            case .nineteen: return "nineteen"
            case .twenty: return "twenty"
            case .twentyone: return "twentyone"
            case .twentytwo: return "twentytwo"
            case .twentythree: return "twentythree"
            }
        }
        
        init?(with string: String) {
            switch string {
            case "one": self = .one
            case "two": self = .two
            case "three": self = .three
            case "four": self = .four
            case "five": self = .five
            case "six": self = .six
            case "seven": self = .seven
            case "eight": self = .eight
            case "nine": self = .nine
            case "ten": self = .ten
            case "eleven": self = .eleven
            case "twelve": self = .twelve
            case "thirteen": self = .thirteen
            case "fourteen": self = .fourteen
            case "fifteen": self = .fifteen
            case "sixteen": self = .sixteen
            case "seventeen": self = .seventeen
            case "eighteen": self = .eighteen
            case "nineteen": self = .nineteen
            case "twenty": self = .twenty
            case "twentyone": self = .twentyone
            case "twentytwo": self = .twentytwo
            case "twentythree": self = .twentythree
            default: return nil
            }
        }
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
        let hours: [String]
    }
    
    init(with info: ReconstitutionInfo) throws {
        var hours = Set<HoursOfTheDay>()
        for val in info.hours {
            if let hour = HoursOfTheDay(with: val) {
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
