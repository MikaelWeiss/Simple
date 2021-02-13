//
//  TasksOverviewService.swift
//  Simple
//
//  Created by Mikael Weiss on 2/12/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

protocol TasksOverviewService {
    func fetchTasks() -> [TasksOverview.Task]
}

extension TasksOverview {
    
    class Service: TasksOverviewService {
        func fetchTasks() -> [TasksOverview.Task] {
            [Task(name: "Wake up", date: Date(), image: Image(uiImage: #imageLiteral(resourceName: "testingImage"))),
             Task(name: "Wake up", date: Date(), image: Image(uiImage: #imageLiteral(resourceName: "testingImage"))),
             Task(name: "Wake up", date: Date(), image: nil)]
        }
    }
}
