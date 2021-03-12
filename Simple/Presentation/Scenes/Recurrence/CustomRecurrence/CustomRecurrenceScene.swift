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
        let currentRecurrence: Recurrence
        let callbacak: (Recurrence) -> Void
    }
    
    private static var input: Input?
    
    static func prepareScene(currentRecurrence: Recurrence, callback: @escaping (Recurrence) -> Void) {
        input = Input(currentRecurrence: currentRecurrence, callbacak: callback)
    }
    
    struct Scene {
        let view: CustomRecurrenceView
        
        init() {
            let service = Self.buildService()
            let presenter = CustomRecurrencePresenter()
            let interactor = CustomRecurrenceInteractor(service: service, presenter: presenter)
            view = CustomRecurrenceView(interactor: interactor, viewModel: presenter.viewModel)
        }
        
        private static func buildService() -> CustomRecurrence.Service {
            guard let input = input else {
                // TODO: Update to show an alert and then dismiss the scene
                fatalError("CustomRecurrence: Missing input")
            }
            return CustomRecurrence.Service(recurrence: input.currentRecurrence)
        }
    }
}
