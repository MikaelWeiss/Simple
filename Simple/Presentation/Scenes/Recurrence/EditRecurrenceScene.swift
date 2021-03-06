//
//  EditRecurrenceScene.swift
//  Simple
//
//  Created by Mikael Weiss on 3/5/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum EditRecurrence {
    struct Scene {
        let view: EditRecurrenceView
        
        init() {
            let service = EditRecurrence.Service()
            let presenter = EditRecurrencePresenter()
            let interactor = EditRecurrenceInteractor(service: service, presenter: presenter)
            view = EditRecurrenceView(interactor: interactor, viewModel: presenter.viewModel)
        }
        
        let service = EditRecurrence.Service()
    }
}
