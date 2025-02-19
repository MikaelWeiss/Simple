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
//    func presentDidChangeFrequency(with response: EditTask.ValidateFrequencySelection.Response)
    func presentDidTapRecurrenceSelection()
    func presentCanSave(with response: EditTask.CanSave.Response)
    func presentDidTapSave(with response: EditTask.DidTapSave.Response)
    func presentDidTapDelete(with response: EditTask.DidTapDelete.Response)
    func presentShowError(with response: EditTask.ShowError.Response)
}

struct EditTaskPresenter: EditTaskPresenting {
    typealias Strings = EditTask.Strings
    
    let viewModel = EditTask.ViewModel()
    
    func presentUpdateTheme() {
        viewModel.nameTitle = EditTask.Strings.nameCellTitle
        viewModel.preferredTimeTitle = EditTask.Strings.dateCellTitle
        viewModel.recurrenceTitle = EditTask.Strings.frequencyCellTitle
    }
    
    func presentFetchTask(with response: EditTask.FetchTask.Response) {
        let taskInfo = response.task
        viewModel.nameInfo = .init(value: response.task.name ?? "", state: .normal)
        viewModel.preferredTime = taskInfo.preferredTime ?? Date.now
        viewModel.taskImage = taskInfo.image
        viewModel.title = taskInfo.taskExists ? EditTask.Strings.editSceneTitle : EditTask.Strings.creationSceneTitle
    }
    
    func presentDidChangeName(with response: EditTask.ValidateName.Response) {
        viewModel.nameInfo = EditTask.ValidateName.TaskInfo(value: response.value, state: response.valid ? .normal : .error)
    }
    
    func presentDidChangeDate(with response: EditTask.ValidateDate.Response) {
        viewModel.preferredTime = response.value
    }
    
//    func presentDidChangeFrequency(with response: EditTask.ValidateFrequencySelection.Response) {
//        viewModel.selectedFrequency = response.selectedFrequency
//    }
    
    func presentDidTapRecurrenceSelection() {
        let alertInfo = (title: Strings.comingSoonAlertTitle, message: Strings.comingSoonAlertMessage, actionTitle: Strings.defaultAlertActionTitle)
        viewModel.alertInfo = alertInfo
        viewModel.isShowingAlert = true
    }
    
    func presentCanSave(with response: EditTask.CanSave.Response) {
        viewModel.canSave = response.canSave
    }
    
    func presentDidTapSave(with response: EditTask.DidTapSave.Response) {
        if response.didSave {
            viewModel.isShowing = false
        }
    }
    
    func presentDidTapDelete(with response: EditTask.DidTapDelete.Response) {
        if response.didDelete {
            viewModel.isShowing = false
        }
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
