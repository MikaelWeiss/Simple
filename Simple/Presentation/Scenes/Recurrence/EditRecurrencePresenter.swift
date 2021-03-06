//
//  EditRecurrencePresenter.swift
//  Simple
//
//  Created by Mikael Weiss on 3/5/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

protocol EditRecurrencePresenting {
    func presentUpdateTheme()
    func presentDidTapDefaultRecurrence(with response: EditRecurrence.DidTapDefaultRecurrence.Response)
    func presentDidTapCustomRepeat()
}

struct EditRecurrencePresenter: EditRecurrencePresenting {
    let viewModel: EditRecurrence.ViewModel
    
    init(isShowing: Binding<Bool>) {
        self.viewModel = EditRecurrence.ViewModel(isShowing: isShowing)
    }
    
    func presentUpdateTheme() {
        viewModel.sceneTitle = EditRecurrence.Strings.sceneTitle
    }
    
    func presentDidTapDefaultRecurrence(with response: EditRecurrence.DidTapDefaultRecurrence.Response) {
        viewModel.selectedDefaultRecurrence = response.recurrence
        viewModel.isShowing = false
    }
    
    func presentDidTapCustomRepeat() {
        viewModel.isShowingCustomRepeat = true
    }
}
