//
//  CustomRecurrenceScene.swift
//  Simple
//
//  Created by Mikael Weiss on 3/6/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum CustomRecurrence {
    struct Scene {
        let view: CustomRecurrenceView
        
        init() {
            let service = CustomRecurrence.Service()
            let presenter = CustomRecurrencePresenter()
            let interactor = CustomRecurrenceInteractor(service: service, presenter: presenter)
            view = CustomRecurrenceView(interactor: interactor, viewModel: presenter.viewModel)
        }
    }
}
