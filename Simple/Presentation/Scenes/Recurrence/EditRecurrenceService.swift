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
    func fetchSelectedDefaultRecurrence() -> DefaultRecurrence
    func fetchRecurrence() -> Recurrence
    func fetchDefaultRecurrenceIsSelected() -> Bool
    func prepareRouteToCustomRecurrence(currentRecurrence: Recurrence, callback: @escaping (Recurrence) -> Void)
}

protocol EditRecurrenceRecurrenceFactory {
    func defaultRecurrence(_ recurrence: DefaultRecurrence) -> Recurrence
}
extension RecurrenceFactory: EditRecurrenceRecurrenceFactory { }

extension EditRecurrence {
    
    class Service: EditRecurrenceService {
        
        private var recurrenceFactory: EditRecurrenceRecurrenceFactory
        private var selectedDefaultRecurrence: DefaultRecurrence = .never
        private var currentRecurrence: Recurrence
        private var defaultRecurrenceIsSelected = true
        private var date: Date
        private var callBack: (Recurrence) -> Void
        
        init(recurrenceFactory: EditRecurrenceRecurrenceFactory, currentRecurrence: Recurrence, date: Date, callback: @escaping (Recurrence) -> Void) {
            self.recurrenceFactory = recurrenceFactory
            self.currentRecurrence = currentRecurrence
            self.date = date
            self.callBack = callback
        }
        
        func fetchDefaultRecurrences() -> [DefaultRecurrence] {
            DefaultRecurrence.allCases
        }
        
        func fetchSelectedDefaultRecurrence() -> DefaultRecurrence {
            selectedDefaultRecurrence
        }
        
        func fetchDefaultRecurrenceIsSelected() -> Bool {
            defaultRecurrenceIsSelected
        }
        
        func fetchRecurrence() -> Recurrence {
            currentRecurrence
        }
        
        func didSelectDefaultRecurrence(recurrence: DefaultRecurrence) throws {
            selectedDefaultRecurrence = recurrence
            currentRecurrence = recurrenceFactory.defaultRecurrence(recurrence)
            defaultRecurrenceIsSelected = true
        }
        
        func didSelectRecurrence(_ recurrence: Recurrence) {
            currentRecurrence = recurrence
            defaultRecurrenceIsSelected = false
        }
        
        func prepareRouteToCustomRecurrence(currentRecurrence: Recurrence, callback: @escaping (Recurrence) -> Void) {
            CustomRecurrence.prepareScene(currentRecurrence: currentRecurrence, callback: callback)
        }
        
        func prepareRouteToPrevious() {
            callBack(currentRecurrence)
        }
    }
}
