//
//  CustomRecurrenceModels.swift
//  Simple
//
//  Created by Mikael Weiss on 3/6/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

extension CustomRecurrence {
    enum SelectedFrequency {
        struct Request {
            let value: CustomRecurrence.Frequency
        }
        struct Response {
            let value: CustomRecurrence.Frequency
        }
    }
    
    enum SelectedInterval {
        struct Request {
            let value: Int
        }
        struct Response {
            let value: Int
        }
    }
    
    enum SelectedDayOfTheWeek {
        struct Request {
            let value: WeeklyRecurrence.DayOfTheWeek
        }
        struct Response {
            let value: WeeklyRecurrence.DayOfTheWeek
        }
    }
    
    enum Strings {
        static let sceneTitle = NSLocalizedString("Custom Repeat", comment: "The title for the scene")
    }
    
    class ViewModel: ObservableObject {
        @Published var sceneTitle = Strings.sceneTitle
        @Published var selectedFrequency: CustomRecurrence.Frequency = .weekly
        @Published var selectedInterval: Int = 1
        @Published var selectedDaysOfTheWeek: Set<WeeklyRecurrence.DayOfTheWeek> = Set(arrayLiteral: .sunday)
    }
}
