//
//  EditRecurrenceInteractor.swift
//  Simple
//
//  Created by Mikael Weiss on 3/5/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol EditRecurrenceRequesting {
    func updateTheme()
    func didChangeValue(with request: EditRecurrence.ValidateValue.Request)
    func prepareRouteToSheet()
    func prepareRouteToOtherScene()
}

struct EditRecurrenceInteractor: EditRecurrenceRequesting {
    private let service: EditRecurrenceService
    private let presenter: EditRecurrencePresenting
    
    init(service: EditRecurrenceService, presenter: EditRecurrencePresenting) {
        self.service = service
        self.presenter = presenter
    }
    
    func updateTheme() {
        presenter.presentUpdateTheme()
    }
    
    func didChangeValue(with request: EditRecurrence.ValidateValue.Request) {
        let response = EditRecurrence.ValidateValue.Response(value: request.value)
        presenter.presentDidChangeValue(with: response)
    }
    
    func prepareRouteToSheet() {
        presenter.presentPrepareRouteToSheet()
    }
    
    func prepareRouteToOtherScene() {
        presenter.presentPrepareRouteToOtherScene()
    }
}
