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
    func fetchTask()
    func didChangeName(with request: EditTask.ValidateName.Request)
    func didChangeDate(with request: EditTask.ValidateDate.Request)
//    func didChangeFrequency(with request: EditTask.ValidateFrequencySelection.Request)
    func checkCanSave()
    func didTapDelete()
    func didTapSave()
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
    
    func fetchTask() {
        tryOrThrow {
            let task = try service.fetchTask()
            let response = EditTask.FetchTask.Response(task: task)
            presenter.presentFetchTask(with: response)
        }
    }
    
    func didChangeName(with request: EditTask.ValidateName.Request) {
        do {
            try service.validateTaskName(to: request.value)
            let response = EditTask.ValidateName.Response(value: request.value, valid: true)
            presenter.presentDidChangeName(with: response)
        } catch {
            let response = EditTask.ValidateName.Response(value: request.value, valid: false)
            presenter.presentDidChangeName(with: response)
        }
    }
    
    func didChangeDate(with request: EditTask.ValidateDate.Request) {
        tryOrThrow {
            try service.validateTaskPreferredTime(to: request.value)
            let response = EditTask.ValidateDate.Response(value: request.value)
            presenter.presentDidChangeDate(with: response)
        }
    }
    
//    func didChangeFrequency(with request: EditTask.ValidateFrequencySelection.Request) {
//        tryOrThrow {
//            try service.validateTaskFrequency(to: request.selectedFrequency)
//            let response = EditTask.ValidateFrequencySelection.Response(selectedFrequency: request.selectedFrequency)
//            presenter.presentDidChangeFrequency(with: response)
//        }
//    }
    
    func didTapDelete() {
        tryOrThrow {
            try service.deleteTask()
            let response = EditTask.DidTapDelete.Response(didDelete: true)
            presenter.presentDidTapDelete(with: response)
        }
    }
    
    func didTapSave() {
        tryOrThrow {
            try service.save()
            let response = EditTask.DidTapSave.Response(didSave: true)
            presenter.presentDidTapSave(with: response)
        }
    }
    
    func checkCanSave() {
        let canSave = service.canSave()
        let response = EditTask.CanSave.Response(canSave: canSave)
        presenter.presentCanSave(with: response)
    }
    
    private func tryOrThrow(_ do: () throws -> Void) {
        do {
            try `do`()
        } catch {
            let response = EditTask.ShowError.Response(error: error as? EditTask.ServiceError ?? .unknown)
            presenter.presentShowError(with: response)
        }
    }
}
