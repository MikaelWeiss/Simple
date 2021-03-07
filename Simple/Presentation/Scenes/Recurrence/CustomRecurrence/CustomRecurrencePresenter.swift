//
//  CustomRecurrencePresenter.swift
//  Simple
//
//  Created by Mikael Weiss on 3/6/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

protocol CustomRecurrencePresenting {
    func presentDidSelectFrequency(with response: CustomRecurrence.SelectedFrequency.Response)
    func presentDidSelectInterval(with response: CustomRecurrence.SelectedInterval.Response)
    func presentDidSelectDayOfTheWeek(with response: CustomRecurrence.SelectedDayOfTheWeek.Response)
}

struct CustomRecurrencePresenter: CustomRecurrencePresenting {
    let viewModel = CustomRecurrence.ViewModel()
    
    func presentFetchTheme() {
        let dayOfTheWeek = try? PresentationSupport.dayOfTheWeek()
        viewModel.selectedDaysOfTheWeek = Set(arrayLiteral: dayOfTheWeek ?? .sunday)
    }
    
    func presentDidSelectFrequency(with response: CustomRecurrence.SelectedFrequency.Response) {
        let frequency = response.value
        viewModel.selectedFrequency = frequency
    }
    
    func presentDidSelectInterval(with response: CustomRecurrence.SelectedInterval.Response) {
    }
    
    func presentDidSelectDayOfTheWeek(with response: CustomRecurrence.SelectedDayOfTheWeek.Response) {
        
    }
}
