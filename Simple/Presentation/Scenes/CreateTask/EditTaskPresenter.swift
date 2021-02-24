//
//  EditTaskPresenter.swift
//  Simple
//
//  Created by Mikael Weiss on 2/13/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit

protocol EditTaskPresenting {
    func presentUpdateTheme()
    func presentFetchTask(with response: EditTask.FetchTask.Response)
    func presentDidChangeName(with response: EditTask.ValidateName.Response)
    func presentDidChangeDate(with response: EditTask.ValidateDate.Response)
    func presentDidChangeFrequency(with response: EditTask.ValidateFrequencySelection.Response)
    func presentCanSave(with response: EditTask.CanSave.Response)
    func presentShowError(with response: EditTask.ShowError.Response)
}

struct EditTaskPresenter: EditTaskPresenting {
    typealias Strings = EditTask.Strings
    
    let viewModel = EditTask.ViewModel()
    
    func presentUpdateTheme() {
        viewModel.title = EditTask.Strings.sceneTitle
        viewModel.nameTitle = EditTask.Strings.nameCellTitle
        viewModel.preferredTimeTitle = EditTask.Strings.dateCellTitle
        viewModel.frequencyTitle = EditTask.Strings.frequencyCellTitle
    }
    
    func presentFetchTask(with response: EditTask.FetchTask.Response) {
        let taskInfo = response.task
        viewModel.name = taskInfo.name ?? ""
        viewModel.preferredTime = taskInfo.preferredTime ?? Date.now
        viewModel.selectedFrequency = taskInfo.frequency ?? .daily
        viewModel.taskImage = taskInfo.image
    }
    
    func presentDidChangeName(with response: EditTask.ValidateName.Response) {
        viewModel.name = response.value
    }
    
    func presentDidChangeDate(with response: EditTask.ValidateDate.Response) {
        viewModel.preferredTime = response.value
    }
    
    func presentDidChangeFrequency(with response: EditTask.ValidateFrequencySelection.Response) {
        viewModel.selectedFrequency = response.selectedFrequency
    }
    
    func presentCanSave(with response: EditTask.CanSave.Response) {
        viewModel.canSave = response.canSave
    }
    
    func presentShowError(with response: EditTask.ShowError.Response) {
        let alertInfo: (title: String, message: String, actionTitle: String)
        switch response.error {
        case .saveFailed: alertInfo = (
            title: Strings.saveFailedAlertTitle,
            message: Strings.saveFailedAlertMessage,
            actionTitle: Strings.defaultAlertActionTitle)
        default: alertInfo = (
            title: Strings.unknownErrorAlertTitle,
            message: Strings.unknownErrorAlertMessage,
            actionTitle: Strings.defaultAlertActionTitle)
        }
        viewModel.alertInfo = alertInfo
        viewModel.isShowingAlert = true
    }
}
