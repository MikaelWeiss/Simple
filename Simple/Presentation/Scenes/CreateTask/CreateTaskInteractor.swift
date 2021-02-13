//
//  CreateTaskInteractor.swift
//  Simple
//
//  Created by Mikael Weiss on 2/13/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol CreateTaskRequesting {
    func updateTheme()
    func didChangeValue(with request: CreateTask.ValidateValue.Request)
    func prepareRouteToSheet()
    func prepareRouteToOtherScene()
}

struct CreateTaskInteractor: CreateTaskRequesting {
    private let service: CreateTaskService
    private let presenter: CreateTaskPresenting
    
    init(service: CreateTaskService, presenter: CreateTaskPresenting) {
        self.service = service
        self.presenter = presenter
    }
    
    func updateTheme() {
        presenter.presentUpdateTheme()
    }
    
    func didChangeValue(with request: CreateTask.ValidateValue.Request) {
        let response = CreateTask.ValidateValue.Response(value: request.value)
        presenter.presentDidChangeValue(with: response)
    }
    
    func prepareRouteToSheet() {
        presenter.presentPrepareRouteToSheet()
    }
    
    func prepareRouteToOtherScene() {
        presenter.presentPrepareRouteToOtherScene()
    }
}
