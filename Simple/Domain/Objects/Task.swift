//
//  Task.swift
//  Simple
//
//  Created by Mikael Weiss on 2/13/21.
//

import SwiftUI

struct Task {
    enum Repetition {
        case daily
        case weekly
        case monthly
        case annually
        case biannually
        
        func stringValue() -> String {
            switch self {
            case .daily: return "daily"
            case .weekly: return "weekly"
            case .monthly: return "monthly"
            case .annually: return "annually"
            case .biannually: return "biannually"
            }
        }
        
        static func allRepetitions() -> [Repetition] {
            [.daily,
             .weekly,
             .monthly,
             .annually,
             .biannually]
        }
    }
    
    var name: String
    var date: Date
    var image: Image?
    var repetition: Repetition = .daily
}
