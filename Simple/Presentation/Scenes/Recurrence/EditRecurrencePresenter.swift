//
//  EditRecurrencePresenter.swift
//  Simple
//
//  Created by Mikael Weiss on 3/5/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

protocol EditRecurrencePresenting {
    func presentSetup(with response: EditRecurrence.Setup.Response)
    func presentDidSelectDefaultRecurrence(with response: EditRecurrence.DidSelectDefaultRecurrence.Response)
    func presentDidTapCustomRecurrence()
}

struct EditRecurrencePresenter: EditRecurrencePresenting {
    typealias Strings = EditRecurrence.Strings
    let viewModel: EditRecurrence.ViewModel
    
    init(isShowing: Binding<Bool>) {
        self.viewModel = EditRecurrence.ViewModel(isShowing: isShowing)
    }
    
    func presentSetup(with response: EditRecurrence.Setup.Response) {
        let cells = response.defaultRecurrences.map {
            EditRecurrence.DidSelectDefaultRecurrence.Cell(recurrence: $0, value: Strings.stringForDefaultRecurrence($0), selected: checkSelected($0, selected: response.selectedDefaultRecurrence))
        }
        
        viewModel.defaultRecurrences = cells
    }
    
    private func checkSelected(_ recurrence: EditRecurrence.DefaultRecurrence, selected: EditRecurrence.DefaultRecurrence?) -> Bool {
        guard let selected = selected else { return false }
        return selected == recurrence ? true : false
    }
    
    func presentDidSelectDefaultRecurrence(with response: EditRecurrence.DidSelectDefaultRecurrence.Response) {
        viewModel.isShowing = false
    }
    
    func presentDidTapCustomRecurrence() {
        viewModel.isShowingCustomRepeat = true
    }
}

