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
    func didTapDefaultRecurrence(with request: EditRecurrence.DidTapDefaultRecurrence.Request)
    func didTapCustomRepeat()
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
    
    func didTapDefaultRecurrence(with request: EditRecurrence.DidTapDefaultRecurrence.Request) {
        let response = EditRecurrence.DidTapDefaultRecurrence.Response(recurrence: request.recurrence)
        presenter.presentDidTapDefaultRecurrence(with: response)
    }
    
    func didTapCustomRepeat() {
        presenter.presentDidTapCustomRepeat()
    }
}
