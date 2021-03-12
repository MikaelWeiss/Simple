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
    func prepareRouteToCustomRecurrence(callback: @escaping (Recurrence) -> Void)
    func didSelectRecurrence(_ recurrence: Recurrence)
}

extension EditRecurrence {
    enum DefaultRecurrence: CaseIterable {
        case never, hourly, daily, weekly, biweekly, monthly, everyThreeMonths, everySixMonths, yearly
    }
    
    class Service: EditRecurrenceService {
        
        private var selectedDefaultRecurrence: DefaultRecurrence?
        private var currentRecurrence: Recurrence?
        
        func fetchDefaultRecurrences() -> [EditRecurrence.DefaultRecurrence] {
            DefaultRecurrence.allCases
        }
        
        func currentRecurrence() -> Recurrence {
            
        }
        
        func fetchSelectedDefaultRecurrence() -> EditRecurrence.DefaultRecurrence? {
            return selectedDefaultRecurrence
        }
        
        func didSelectDefaultRecurrence(recurrence: EditRecurrence.DefaultRecurrence) {
            self.selectedDefaultRecurrence = recurrence
        }
        
        func didSelectRecurrence(_ recurrence: Recurrence) {
            self.selectedDefaultRecurrence = nil
            self.currentRecurrence = recurrence
        }
        
        func prepareRouteToCustomRecurrence(currentRecurrence: Recurrence, callback: @escaping (Recurrence) -> Void) {
            CustomRecurrence.Scene.prepNLanding(currentRecurrence: currentRecurrence, callback: callback)
        }
    }
}
