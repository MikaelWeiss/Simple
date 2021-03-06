//
//  CustomRecurrenceInteractor.swift
//  Simple
//
//  Created by Mikael Weiss on 3/6/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol CustomRecurrenceRequesting {
    func updateTheme()
    func didChangeValue(with request: CustomRecurrence.ValidateValue.Request)
    func prepareRouteToSheet()
    func prepareRouteToOtherScene()
}

struct CustomRecurrenceInteractor: CustomRecurrenceRequesting {
    private let service: CustomRecurrenceService
    private let presenter: CustomRecurrencePresenting
    
    init(service: CustomRecurrenceService, presenter: CustomRecurrencePresenting) {
        self.service = service
        self.presenter = presenter
    }
    
    func updateTheme() {
        presenter.presentUpdateTheme()
    }
    
    func didChangeValue(with request: CustomRecurrence.ValidateValue.Request) {
        let response = CustomRecurrence.ValidateValue.Response(value: request.value)
        presenter.presentDidChangeValue(with: response)
    }
    
    func prepareRouteToSheet() {
        presenter.presentPrepareRouteToSheet()
    }
    
    func prepareRouteToOtherScene() {
        presenter.presentPrepareRouteToOtherScene()
    }
}
