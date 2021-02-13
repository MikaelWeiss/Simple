//
//  TasksOverviewInteractor.swift
//  Simple
//
//  Created by Mikael Weiss on 2/12/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

protocol TasksOverviewRequesting {
    func updateTheme()
    func fetchTasks()
    func prepareRouteToSheet()
    func prepareRouteToOtherScene()
}

struct TasksOverviewInteractor: TasksOverviewRequesting {
    private let service: TasksOverviewService
    private let presenter: TasksOverviewPresenting
    
    init(service: TasksOverviewService, presenter: TasksOverviewPresenting) {
        self.service = service
        self.presenter = presenter
    }
    
    func updateTheme() {
        presenter.presentUpdateTheme()
    }
    
    func fetchTasks() {
        let fetchedTasks = service.fetchTasks()
        let response = TasksOverview.FetchTasks.Response(tasks: fetchedTasks)
        presenter.presentFetchTasks(with: response)
    }
    
    func prepareRouteToSheet() {
        presenter.presentPrepareRouteToSheet()
    }
    
    func prepareRouteToOtherScene() {
        presenter.presentPrepareRouteToOtherScene()
    }
}
