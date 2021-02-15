//
//  Repetition.swift
//  Simple
//
//  Created by Mikael Weiss on 2/15/21.
//

import Foundation

enum Repetition {
    case daily
    case weekly
    case monthly
    case annually
    case biannually
    
    // MARK: - Initialization
    
    init?(with string: String) {
        switch string {
        case "daily": self = .daily
        case "weekly": self = .weekly
        case "monthly": self = .monthly
        case "annually": self = .annually
        case "biannually": self = .biannually
        default: return nil
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
