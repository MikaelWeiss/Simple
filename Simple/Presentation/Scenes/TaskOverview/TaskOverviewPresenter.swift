//
//  TaskOverviewPresenter.swift
//  Simple
//
//  Created by Mikael Weiss on 2/12/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit

protocol TaskOverviewPresenting {
    func presentDidChangeValue(with response: TaskOverview.ValidateValue.Response)
    func presentUpdateTheme()
    func presentPrepareRouteToSheet()
    func presentPrepareRouteToOtherScene()
}

struct TaskOverviewPresenter: TaskOverviewPresenting {
    let viewModel = TaskOverview.ViewModel()
    
    func presentUpdateTheme() {
        viewModel.title = TaskOverview.Strings.sceneTitle
        viewModel.textFieldTitle = TaskOverview.Strings.textFieldTitle
    }
    
    func presentDidChangeValue(with response: TaskOverview.ValidateValue.Response) {
        viewModel.textFieldValue = response.value
    }
    
    func presentPrepareRouteToSheet() {
        viewModel.isShowingSheet = true
    }
    
    func presentPrepareRouteToOtherScene() {
        viewModel.isShowingOtherScene = true
    }
}
