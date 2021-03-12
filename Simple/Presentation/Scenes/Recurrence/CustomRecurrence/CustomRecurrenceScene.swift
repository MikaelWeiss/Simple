//
//  CustomRecurrenceScene.swift
//  Simple
//
//  Created by Mikael Weiss on 3/6/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum CustomRecurrence {
    
    struct Input {
        let currentRecurrence: Recurrence?
    }
    
    struct Scene {
        private static var input: Input?
        
        let view: CustomRecurrenceView
        
        init() {
            let service = Self.buildService()
            let presenter = CustomRecurrencePresenter()
            let interactor = CustomRecurrenceInteractor(service: service, presenter: presenter)
            view = CustomRecurrenceView(interactor: interactor, viewModel: presenter.viewModel)
        }
        
        private static func buildService() -> CustomRecurrence.Service {
            guard let input = Self.input else {
                // TODO: Update to show an alert and then dismiss the scene
                fatalError("Missing input")
            }
            return CustomRecurrence.Service(recurrence: input.currentRecurrence)
        }
        
        static func prepNLanding(currentRecurrence: Recurrence) {
            input = Input(currentRecurrence: currentRecurrence)
        }
    }
}
