//
//  EditTaskService.swift
//  Simple
//
//  Created by Mikael Weiss on 2/13/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol EditTaskService {
    func fetchFrequencies() -> [Frequency]
}

extension EditTask {
    
    class Service: EditTaskService {
        func fetchFrequencies() -> [Frequency] {
            Frequency.allCases
        }
    }
}
