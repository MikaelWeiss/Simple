//
//  EditRecurrencePresenter.swift
//  Simple
//
//  Created by Mikael Weiss on 3/5/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit

protocol EditRecurrencePresenting {
    func presentDidChangeValue(with response: EditRecurrence.ValidateValue.Response)
    func presentUpdateTheme()
    func presentPrepareRouteToSheet()
    func presentPrepareRouteToOtherScene()
}

struct EditRecurrencePresenter: EditRecurrencePresenting {
    let viewModel = EditRecurrence.ViewModel()
    
    func presentUpdateTheme() {
        viewModel.title = EditRecurrence.Strings.sceneTitle
        viewModel.textFieldTitle = EditRecurrence.Strings.textFieldTitle
    }
    
    func presentDidChangeValue(with response: EditRecurrence.ValidateValue.Response) {
        viewModel.textFieldValue = response.value
    }
    
    func presentPrepareRouteToSheet() {
        viewModel.sheetShowing = true
    }
    
    func presentPrepareRouteToOtherScene() {
        viewModel.isShowingOtherScene = true
    }
}
