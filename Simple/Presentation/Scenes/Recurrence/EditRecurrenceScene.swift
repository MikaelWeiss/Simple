//
//  EditRecurrenceScene.swift
//  Simple
//
//  Created by Mikael Weiss on 3/5/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

enum EditRecurrence {
    struct Scene {
        let view: EditRecurrenceView
        
        init(isShowing: Binding<Bool>) {
            let service = EditRecurrence.Service()
            let presenter = EditRecurrencePresenter(isShowing: isShowing)
            let interactor = EditRecurrenceInteractor(service: service, presenter: presenter)
            view = EditRecurrenceView(interactor: interactor, viewModel: presenter.viewModel)
        }
        
        let service = EditRecurrence.Service()
    }
}
