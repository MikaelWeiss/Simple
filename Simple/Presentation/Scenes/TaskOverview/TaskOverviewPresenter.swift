//
//  TaskOverviewPresenter.swift
//  Simple
//
//  Created by Mikael Weiss on 2/12/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

protocol TaskOverviewPresenting {
    func presentUpdateTheme()
    func presentPrepareRouteToSheet()
    func presentPrepareRouteToOtherScene()
}

struct TaskOverviewPresenter: TaskOverviewPresenting {
    let viewModel = TaskOverview.ViewModel()
    
    func presentUpdateTheme() {
        viewModel.title = TaskOverview.Strings.sceneTitle
    }
    
    func presentPrepareRouteToSheet() {
        viewModel.isShowingSheet = true
    }
    
    func presentPrepareRouteToOtherScene() {
        viewModel.isShowingOtherScene = true
    }
}
