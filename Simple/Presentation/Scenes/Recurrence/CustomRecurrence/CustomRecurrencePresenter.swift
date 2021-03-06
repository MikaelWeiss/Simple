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
    func presentDidSelectFrequency(with request: CustomRecurrence.SelectedFrequency.Response)
    func presentDidSelectInterval(with request: CustomRecurrence.SelectedInterval.Response)
}

struct CustomRecurrencePresenter: CustomRecurrencePresenting {
    let viewModel = CustomRecurrence.ViewModel()
    
    func presentDidSelectFrequency(with request: CustomRecurrence.SelectedFrequency.Response) {
    }
    
    func presentDidSelectInterval(with request: CustomRecurrence.SelectedInterval.Response) {
    }
}
