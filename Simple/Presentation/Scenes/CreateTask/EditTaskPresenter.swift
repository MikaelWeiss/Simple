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
    func presentFetchRepetition(with response: EditTask.FetchRepetition.Response)
    func presentDidChangeName(with response: EditTask.ValidateName.Response)
    func presentDidChangeDate(with response: EditTask.ValidateDate.Response)
    func presentDidChangeRepetition(with response: EditTask.ValidateRepetitionSelection.Response)
    func presentPrepareRouteToSheet()
    func presentPrepareRouteToOtherScene()
}

struct EditTaskPresenter: EditTaskPresenting {
    let viewModel = EditTask.ViewModel()
    
    func presentUpdateTheme() {
        viewModel.title = EditTask.Strings.sceneTitle
        viewModel.nameCellTitle = EditTask.Strings.nameCellTitle
        viewModel.dateCellTitle = EditTask.Strings.dateCellTitle
        viewModel.dateCellTitle = EditTask.Strings.dateCellTitle
    }
    
    func presentFetchRepetition(with response: EditTask.FetchRepetition.Response) {
        viewModel.repetitions = response.repetitions
    }
    
    func presentDidChangeName(with response: EditTask.ValidateName.Response) {
        viewModel.nameCellValue = response.value
    }
    
    func presentDidChangeDate(with response: EditTask.ValidateDate.Response) {
        viewModel.dateCellValue = response.value
    }
    
    func presentDidChangeRepetition(with response: EditTask.ValidateRepetitionSelection.Response) {
        
    }
    
    func presentPrepareRouteToSheet() {
        viewModel.isShowingSheet = true
    }
    
    func presentPrepareRouteToOtherScene() {
        viewModel.isShowingOtherScene = true
    }
}
