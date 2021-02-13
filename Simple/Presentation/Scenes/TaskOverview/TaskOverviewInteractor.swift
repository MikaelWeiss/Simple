//
//  TaskOverviewInteractor.swift
//  Simple
//
//  Created by Mikael Weiss on 2/12/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol TaskOverviewRequesting {
    func updateTheme()
    func didChangeValue(with request: TaskOverview.ValidateValue.Request)
    func prepareRouteToSheet()
    func prepareRouteToOtherScene()
}

struct TaskOverviewInteractor: TaskOverviewRequesting {
    private let service: TaskOverviewService
    private let presenter: TaskOverviewPresenting
    
    init(service: TaskOverviewService, presenter: TaskOverviewPresenting) {
        self.service = service
        self.presenter = presenter
    }
    
    func updateTheme() {
        presenter.presentUpdateTheme()
    }
    
    func didChangeValue(with request: TaskOverview.ValidateValue.Request) {
        let response = TaskOverview.ValidateValue.Response(value: request.value)
        presenter.presentDidChangeValue(with: response)
    }
    
    func prepareRouteToSheet() {
        presenter.presentPrepareRouteToSheet()
    }
    
    func prepareRouteToOtherScene() {
        presenter.presentPrepareRouteToOtherScene()
    }
}
