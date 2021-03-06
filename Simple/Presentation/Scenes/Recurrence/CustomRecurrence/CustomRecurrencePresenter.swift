//
//  CustomRecurrencePresenter.swift
//  Simple
//
//  Created by Mikael Weiss on 3/6/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit

protocol CustomRecurrencePresenting {
    func presentDidChangeValue(with response: CustomRecurrence.ValidateValue.Response)
    func presentUpdateTheme()
    func presentPrepareRouteToSheet()
    func presentPrepareRouteToOtherScene()
}

struct CustomRecurrencePresenter: CustomRecurrencePresenting {
    let viewModel = CustomRecurrence.ViewModel()
    
    func presentUpdateTheme() {
        viewModel.title = CustomRecurrence.Strings.sceneTitle
        viewModel.textFieldTitle = CustomRecurrence.Strings.textFieldTitle
    }
    
    func presentDidChangeValue(with response: CustomRecurrence.ValidateValue.Response) {
        viewModel.textFieldValue = response.value
    }
    
    func presentPrepareRouteToSheet() {
        viewModel.isShowingSheet = true
    }
    
    func presentPrepareRouteToOtherScene() {
        viewModel.isShowingOtherScene = true
    }
}
