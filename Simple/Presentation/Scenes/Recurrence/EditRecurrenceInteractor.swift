//
//  EditRecurrenceInteractor.swift
//  Simple
//
//  Created by Mikael Weiss on 3/5/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol EditRecurrenceRequesting {
    func setup()
    func didTapDefaultRecurrence(with request: EditRecurrence.DidSelectDefaultRecurrence.Request)
    func didTapCustomRepeat()
}

struct EditRecurrenceInteractor: EditRecurrenceRequesting {
    private let service: EditRecurrenceService
    private let presenter: EditRecurrencePresenting
    
    init(service: EditRecurrenceService, presenter: EditRecurrencePresenting) {
        self.service = service
        self.presenter = presenter
    }
    
    func setup() {
        let defaultRecurrences = service.fetchDefaultRecurrences()
        let selectedDefaultRecurrence = service.fetchSelectedDefaultRecurrence()
        let response = EditRecurrence.Setup.Response(defaultRecurrences: defaultRecurrences, selectedDefaultRecurrence: selectedDefaultRecurrence)
        presenter.presentSetup(with: response)
    }
    
    func didTapDefaultRecurrence(with request: EditRecurrence.DidSelectDefaultRecurrence.Request) {
        service.didSelectDefaultRecurrence(recurrence: request.recurrence)
        let response = EditRecurrence.DidSelectDefaultRecurrence.Response(recurrence: request.recurrence)
        presenter.presentDidSelectDefaultRecurrence(with: response)
    }
    
    func didTapCustomRepeat() {
        presenter.presentDidTapCustomRepeat()
    }
}
