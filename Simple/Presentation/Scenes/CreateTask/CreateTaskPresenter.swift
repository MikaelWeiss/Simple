//
//  CreateTaskPresenter.swift
//  Simple
//
//  Created by Mikael Weiss on 2/13/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit

protocol CreateTaskPresenting {
    func presentUpdateTheme()
    func presentFetchRepetition(with response: CreateTask.FetchRepetition.Response)
    func presentDidChangeName(with response: CreateTask.ValidateName.Response)
    func presentDidChangeDate(with response: CreateTask.ValidateDate.Response)
    func presentDidChangeRepetition(with response: CreateTask.ValidateRepetitionSelection.Response)
    func presentPrepareRouteToSheet()
    func presentPrepareRouteToOtherScene()
}

struct CreateTaskPresenter: CreateTaskPresenting {
    let viewModel = CreateTask.ViewModel()
    
    func presentUpdateTheme() {
        viewModel.title = CreateTask.Strings.sceneTitle
        viewModel.nameCellTitle = CreateTask.Strings.nameCellTitle
        viewModel.dateCellTitle = CreateTask.Strings.dateCellTitle
        viewModel.dateCellTitle = CreateTask.Strings.dateCellTitle
    }
    
    func presentFetchRepetition(with response: CreateTask.FetchRepetition.Response) {
        viewModel.repetitions = response.repetitions
    }
    
    func presentDidChangeName(with response: CreateTask.ValidateName.Response) {
        viewModel.nameCellValue = response.value
    }
    
    func presentDidChangeDate(with response: CreateTask.ValidateDate.Response) {
        viewModel.dateCellValue = response.value
    }
    
    func presentDidChangeRepetition(with response: CreateTask.ValidateRepetitionSelection.Response) {
        
    }
    
    func presentPrepareRouteToSheet() {
        viewModel.isShowingSheet = true
    }
    
    func presentPrepareRouteToOtherScene() {
        viewModel.isShowingOtherScene = true
    }
}
