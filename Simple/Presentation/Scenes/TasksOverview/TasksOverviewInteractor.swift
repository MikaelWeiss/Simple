//
//  TasksOverviewInteractor.swift
//  Simple
//
//  Created by Mikael Weiss on 2/12/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI
import Combine

protocol TasksOverviewRequesting {
    func updateTheme()
    func fetchTasks()
    func prepareRouteToEditTask()
}

struct TasksOverviewInteractor: TasksOverviewRequesting {
    
    private let service: TasksOverviewService
    private let presenter: TasksOverviewPresenting
    
    private var updateSubscriber: AnyCancellable?
    
    init(service: TasksOverviewService, presenter: TasksOverviewPresenting) {
        self.service = service
        self.presenter = presenter
        updateSubscriber = service.updatePublisher
            .receive(on: RunLoop.main)
            .sink { [self] _ in
                self.fetchTasks()
            }
    }
    
    func updateTheme() {
        presenter.presentUpdateTheme()
    }
    
    func fetchTasks() {
        do {
            let fetchedTasks = try service.fetchTasks()
            let response = TasksOverview.FetchTasks.Response(tasks: fetchedTasks)
            presenter.presentFetchTasks(with: response)
        } catch {
            let response = TasksOverview.ShowError.Response(error: error as? TasksOverview.ServiceError ?? .unknownError)
            presenter.presentShowError(with: response)
        }
    }
    
    func prepareRouteToEditTask() {
        presenter.presentPrepareRouteToEditTask()
    }
}
