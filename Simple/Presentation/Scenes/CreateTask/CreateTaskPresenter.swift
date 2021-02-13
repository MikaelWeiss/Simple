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
    func presentDidChangeValue(with response: CreateTask.ValidateValue.Response)
    func presentUpdateTheme()
    func presentPrepareRouteToSheet()
    func presentPrepareRouteToOtherScene()
}

struct CreateTaskPresenter: CreateTaskPresenting {
    let viewModel = CreateTask.ViewModel()
    
    func presentUpdateTheme() {
        viewModel.title = CreateTask.Strings.sceneTitle
        viewModel.textFieldTitle = CreateTask.Strings.textFieldTitle
    }
    
    func presentDidChangeValue(with response: CreateTask.ValidateValue.Response) {
        viewModel.textFieldValue = response.value
    }
    
    func presentPrepareRouteToSheet() {
        viewModel.isShowingSheet = true
    }
    
    func presentPrepareRouteToOtherScene() {
        viewModel.isShowingOtherScene = true
    }
}
