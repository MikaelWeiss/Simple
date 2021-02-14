//
//  CreateTaskService.swift
//  Simple
//
//  Created by Mikael Weiss on 2/13/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol CreateTaskService {
    func fetchRepetitions() -> [Task.Repetition]
}

extension CreateTask {
    
    class Service: CreateTaskService {
        func fetchRepetitions() -> [Task.Repetition] {
            Task.Repetition.allRepetitions()
        }
    }
}
