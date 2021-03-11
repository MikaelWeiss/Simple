//
//  EditRecurrenceService.swift
//  Simple
//
//  Created by Mikael Weiss on 3/5/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol EditRecurrenceService {
    func fetchDefaultRecurrences() -> [EditRecurrence.DefaultRecurrence]
    func didSelectDefaultRecurrence(recurrence: EditRecurrence.DefaultRecurrence)
    func fetchSelectedDefaultRecurrence() -> EditRecurrence.DefaultRecurrence?
}

extension EditRecurrence {
    enum DefaultRecurrence: CaseIterable {
        case never, hourly, daily, weekly, biweekly, monthly, everyThreeMonths, everySixMonths, yearly
    }
    
    class Service: EditRecurrenceService {
        
        private var selectedDefaultRecurrence: DefaultRecurrence?
        
        func fetchDefaultRecurrences() -> [EditRecurrence.DefaultRecurrence] {
            DefaultRecurrence.allCases
        }
        
        func fetchSelectedDefaultRecurrence() -> EditRecurrence.DefaultRecurrence? {
            return selectedDefaultRecurrence
        }
        
        func didSelectDefaultRecurrence(recurrence: EditRecurrence.DefaultRecurrence) {
            self.selectedDefaultRecurrence = recurrence
        }
    }
}
