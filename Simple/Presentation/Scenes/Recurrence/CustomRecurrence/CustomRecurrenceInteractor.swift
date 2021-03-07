//
//  CustomRecurrenceInteractor.swift
//  Simple
//
//  Created by Mikael Weiss on 3/6/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol CustomRecurrenceRequesting {
    func fetchTheme()
    func didSelectFrequency(with request: CustomRecurrence.SelectedFrequency.Request)
    func didSelectInterval(with request: CustomRecurrence.SelectedInterval.Request)
    func didSelectDayOfTheWeek(with request: CustomRecurrence.SelectedDayOfTheWeek.Request)
}

struct CustomRecurrenceInteractor: CustomRecurrenceRequesting {
    private let service: CustomRecurrenceService
    private let presenter: CustomRecurrencePresenting
    
    init(service: CustomRecurrenceService, presenter: CustomRecurrencePresenting) {
        self.service = service
        self.presenter = presenter
    }
    
    func fetchTheme() {
        presenter.presentFetchTheme()
    }
    
    func didSelectFrequency(with request: CustomRecurrence.SelectedFrequency.Request) {
        let response = CustomRecurrence.SelectedFrequency.Response(value: request.value)
        presenter.presentDidSelectFrequency(with: response)
    }
    
    func didSelectInterval(with request: CustomRecurrence.SelectedInterval.Request) {
        let response = CustomRecurrence.SelectedInterval.Response(value: request.value)
        presenter.presentDidSelectInterval(with: response)
    }
    
    func didSelectDayOfTheWeek(with request: CustomRecurrence.SelectedDayOfTheWeek.Request) {
        let response = CustomRecurrence.SelectedDayOfTheWeek.Response(value: request.value)
        presenter.presentDidSelectDayOfTheWeek(with: response)
    }
}
