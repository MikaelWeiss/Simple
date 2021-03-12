//
//  EditRecurrenceService.swift
//  Simple
//
//  Created by Mikael Weiss on 3/5/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol EditRecurrenceService {
    func fetchDefaultRecurrences() -> [DefaultRecurrence]
    func didSelectDefaultRecurrence(recurrence: DefaultRecurrence) throws
    func didSelectRecurrence(_ recurrence: Recurrence)
    func fetchRecurrence() -> Recurrence
    func prepareRouteToCustomRecurrence(currentRecurrence: Recurrence, callback: @escaping (Recurrence) -> Void)
}

protocol EditRecurrenceRecurrenceFactory {
    func defaultRecurrence(_ recurrence: DefaultRecurrence, for date: Date) throws -> Recurrence
}
extension RecurrenceFactory: EditRecurrenceRecurrenceFactory { }

extension EditRecurrence {
    
    class Service: EditRecurrenceService {
        
        private var recurrenceFactory: EditRecurrenceRecurrenceFactory
        private var currentRecurrence: Recurrence
        private var date: Date
        
        init(recurrenceFactory: EditRecurrenceRecurrenceFactory, currentRecurrence: Recurrence, date: Date) {
            self.recurrenceFactory = recurrenceFactory
            self.currentRecurrence = currentRecurrence
            self.date = date
        }
        
        func fetchDefaultRecurrences() -> [DefaultRecurrence] {
            DefaultRecurrence.allCases
        }
        
        func fetchRecurrence() -> Recurrence {
            currentRecurrence
        }
        
        func didSelectDefaultRecurrence(recurrence: DefaultRecurrence) throws {
            currentRecurrence = try recurrenceFactory.defaultRecurrence(recurrence, for: date)
        }
        
        func didSelectRecurrence(_ recurrence: Recurrence) {
            currentRecurrence = recurrence
        }
        
        func prepareRouteToCustomRecurrence(currentRecurrence: Recurrence, callback: @escaping (Recurrence) -> Void) {
            CustomRecurrence.Scene.prepNLanding(currentRecurrence: currentRecurrence, callback: callback)
        }
    }
}
