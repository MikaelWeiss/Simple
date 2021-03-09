//
//  EditRecurrenceService.swift
//  Simple
//
//  Created by Mikael Weiss on 3/5/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol EditRecurrenceService {
}

extension EditRecurrence {
    
    enum DefaultRecurrence: CaseIterable {
        case never, hourly, daily, weekly, biweekly, monthly, everyThreeMonths, everySixMonths, yearly
    }
    
    class Service: EditRecurrenceService {
    }
}
