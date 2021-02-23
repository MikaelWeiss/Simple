//
//  EditTaskInteractor.swift
//  Simple
//
//  Created by Mikael Weiss on 2/13/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol EditTaskRequesting {
    func updateTheme()
    func fetchRepetitions()
    func didChangeName(with request: EditTask.ValidateName.Request)
    func didChangeDate(with request: EditTask.ValidateDate.Request)
    func didChangeRepetition(with request: EditTask.ValidateRepetitionSelection.Request)
    func prepareRouteToSheet()
    func prepareRouteToOtherScene()
}

struct EditTaskInteractor: EditTaskRequesting {
    private let service: EditTaskService
    private let presenter: EditTaskPresenting
    
    init(service: EditTaskService, presenter: EditTaskPresenting) {
        self.service = service
        self.presenter = presenter
    }
    
    func updateTheme() {
        presenter.presentUpdateTheme()
    }
    
    func fetchRepetitions() {
        let repetitions = service.fetchFrequencies()
        let response = EditTask.FetchRepetition.Response(repetitions: repetitions)
        presenter.presentFetchRepetition(with: response)
    }
    
    func didChangeName(with request: EditTask.ValidateName.Request) {
        let response = EditTask.ValidateName.Response(value: request.value)
        presenter.presentDidChangeName(with: response)
    }
    
    func didChangeDate(with request: EditTask.ValidateDate.Request) {
        let response = EditTask.ValidateDate.Response(value: request.value)
        presenter.presentDidChangeDate(with: response)
    }
    
    func didChangeRepetition(with request: EditTask.ValidateRepetitionSelection.Request) {
        let response = EditTask.ValidateRepetitionSelection.Response(selectedRepetition: request.selectedRepetition)
        presenter.presentDidChangeRepetition(with: response)
    }
    
    func prepareRouteToSheet() {
        presenter.presentPrepareRouteToSheet()
    }
    
    func prepareRouteToOtherScene() {
        presenter.presentPrepareRouteToOtherScene()
    }
}
