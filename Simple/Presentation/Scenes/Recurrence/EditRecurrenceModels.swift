//
//  EditRecurrenceModels.swift
//  Simple
//
//  Created by Mikael Weiss on 3/5/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

extension EditRecurrence {
    
    enum Setup {
        struct Response {
            let defaultRecurrences: [DefaultRecurrence]
            let selectedDefaultRecurrence: DefaultRecurrence?
        }
    }
    
    enum DidSelectDefaultRecurrence {
        struct Request {
            let recurrence: DefaultRecurrence
        }
        struct Response {
            let recurrence: DefaultRecurrence
        }
        
        struct Cell: Identifiable {
            let id = UUID()
            let recurrence: DefaultRecurrence
            let value: String
            let selected: Bool
        }
    }
    
    enum Strings {
        static let sceneTitle = NSLocalizedString("EditRecurrence-sceneTitle", comment: "EditRecurrence - The title for the scene")
        static func stringForDefaultRecurrence(_ recurrence: DefaultRecurrence) -> String {
            switch recurrence {
            case .never: return NSLocalizedString("EditRecurrence-defaultRecurrenceNever", comment: "EditRecurrence - Default recurrence Never title")
            case .hourly: return NSLocalizedString("EditRecurrence-defaultRecurrenceHourly", comment: "EditRecurrence - Default recurrence Hourly title")
            case .daily: return NSLocalizedString("EditRecurrence-defaultRecurrenceDaily", comment: "EditRecurrence - Default recurrence Daily title")
            case .weekly: return NSLocalizedString("EditRecurrence-defaultRecurrenceWeekly", comment: "EditRecurrence - Default recurrence Weekly title")
            case .biweekly: return NSLocalizedString("EditRecurrence-defaultRecurrenceBiweekly", comment: "EditRecurrence - Default recurrence Biweekly title")
            case .monthly: return NSLocalizedString("EditRecurrence-defaultRecurrenceMonthly", comment: "EditRecurrence - Default recurrence Monthly title") // "Monthly"
            case .everyThreeMonths: return NSLocalizedString("EditRecurrence-defaultRecurrenceEveryThreeMonths", comment: "EditRecurrence - Default recurrence Every three Months title")
            case .everySixMonths: return NSLocalizedString("EditRecurrence-defaultRecurrenceEverySixMonths", comment: "EditRecurrence - Default recurrence Every Six Months title")
            case .yearly: return NSLocalizedString("EditRecurrence-defaultRecurrenceYearly", comment: "EditRecurrence - Default recurrence Yearly title")
            }
        }
    }
    
    class ViewModel: ObservableObject {
        @Published var sceneTitle = Strings.sceneTitle
        @Published var isShowingCustomRepeat = false
        @Published var defaultRecurrences: [DidSelectDefaultRecurrence.Cell] = [.init(recurrence: .daily, value: "Daily", selected: false)]
        @Binding var isShowing: Bool
        
        init(isShowing: Binding<Bool>) {
            self._isShowing = isShowing
        }
    }
}
