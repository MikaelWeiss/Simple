//
//  EditRecurrenceScene.swift
//  Simple
//
//  Created by Mikael Weiss on 3/5/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

enum EditRecurrence {
    
    struct Input {
        let currentRecurrence: Recurrence
        let date: Date
    }
    
    private static var input: Input?
    
    static func prepareScene(currentRecurrence: Recurrence, date: Date) {
        input = Input(currentRecurrence: currentRecurrence, date: date)
    }
    
    struct Scene {
        let view: EditRecurrenceView
        
        init(isShowing: Binding<Bool>) {
            let service = Self.buildService()
            let presenter = EditRecurrencePresenter(isShowing: isShowing)
            let interactor = EditRecurrenceInteractor(service: service, presenter: presenter)
            view = EditRecurrenceView(interactor: interactor, viewModel: presenter.viewModel)
        }
        
        private static func buildService() -> EditRecurrence.Service {
            guard let input = input else {
                // TODO: Update to show an alert and then dismiss the scene
                fatalError("EditRecurrence: Missing input")
            }
            
            return EditRecurrence.Service(
                recurrenceFactory: RecurrenceFactory(),
                currentRecurrence: input.currentRecurrence,
                date: input.date)
        }
    }
}
