//
//  CustomRecurrenceService.swift
//  Simple
//
//  Created by Mikael Weiss on 3/6/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol CustomRecurrenceService {
    func fetchRecurrence() -> Recurrence
}

extension CustomRecurrence {
    
    class Service: CustomRecurrenceService {
        private let recurrence: Recurrence
        
        init(recurrence: Recurrence) {
            self.recurrence = recurrence
        }
        
        func fetchRecurrence() -> Recurrence {
            return recurrence
        }
    }
}
