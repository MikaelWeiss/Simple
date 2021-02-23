//
//  TasksOverviewService.swift
//  Simple
//
//  Created by Mikael Weiss on 2/12/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

protocol TasksOverviewService {
    func fetchTasks() -> [Task]
}

extension TasksOverview {
    
    class Service: TasksOverviewService {
        func fetchTasks() -> [Task] {
            [Task(name: "Wake up", preferredTime: Date(), frequency: .daily, image: UIImage(#imageLiteral(resourceName: "testingImage"))),
             Task(name: "Wake up", preferredTime: Date(), frequency: .daily, image: UIImage(#imageLiteral(resourceName: "testingImage"))),
             Task(name: "Wake up", preferredTime: Date(), frequency: .daily, image: nil)]
        }
    }
}
