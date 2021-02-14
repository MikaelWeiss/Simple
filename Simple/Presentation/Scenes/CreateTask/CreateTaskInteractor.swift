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
    func fetchRepetitions()
    func didChangeName(with request: CreateTask.ValidateName.Request)
    func didChangeDate(with request: CreateTask.ValidateDate.Request)
    func didChangeRepetition(with request: CreateTask.ValidateRepetitionSelection.Request)
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
    
    func fetchRepetitions() {
        let repetitions = service.fetchRepetitions()
        let response = CreateTask.FetchRepetition.Response(repetitions: repetitions)
        presenter.presentFetchRepetition(with: response)
    }
    
    func didChangeName(with request: CreateTask.ValidateName.Request) {
        let response = CreateTask.ValidateName.Response(value: request.value)
        presenter.presentDidChangeName(with: response)
    }
    
    func didChangeDate(with request: CreateTask.ValidateDate.Request) {
        let response = CreateTask.ValidateDate.Response(value: request.value)
        presenter.presentDidChangeDate(with: response)
    }
    
    func didChangeRepetition(with request: CreateTask.ValidateRepetitionSelection.Request) {
        let response = CreateTask.ValidateRepetitionSelection.Response(selectedRepetition: request.selectedRepetition)
        presenter.presentDidChangeRepetition(with: response)
    }
    
    func prepareRouteToSheet() {
        presenter.presentPrepareRouteToSheet()
    }
    
    func prepareRouteToOtherScene() {
        presenter.presentPrepareRouteToOtherScene()
    }
}
