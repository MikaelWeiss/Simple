//
//  Frequency.swift
//  Simple
//
//  Created by Mikael Weiss on 2/15/21.
//

import Foundation

enum Frequency {
    case daily
    case weekly
    case monthly
    case annually
    case biannually
    
    // MARK: - Initialization
    
    init(with string: String?) {
        guard let string = string else { self = .daily; return }
        switch string {
        case "daily": self = .daily
        case "weekly": self = .weekly
        case "monthly": self = .monthly
        case "annually": self = .annually
        case "biannually": self = .biannually
        default: self = .daily
        }
    }
    
    var stringValue: String {
        switch self {
        case .daily: return "daily"
        case .weekly: return "weekly"
        case .monthly: return "monthly"
        case .annually: return "annually"
        case .biannually: return "biannually"
        }
    }
}
