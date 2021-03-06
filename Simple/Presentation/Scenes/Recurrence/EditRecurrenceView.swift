//
//  EditRecurrenceView.swift
//  Simple
//
//  Created by Mikael Weiss on 3/5/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

protocol EditRecurrenceInputing {
    func didChangeValue(to value: String)
    func prepareRouteToSheet()
    func prepareRouteToOtherScene()
}

struct EditRecurrenceView: View {
    @ObservedObject private var viewModel: EditRecurrence.ViewModel
    private let interactor: EditRecurrenceRequesting
    
    init(interactor: EditRecurrenceRequesting, viewModel: EditRecurrence.ViewModel) {
        self.interactor = interactor
        self.viewModel = viewModel
    }
    
    // MARK: - View Lifecycle
    var body: some View {
        VStack {
            ForEach(data: Recurrence.Default) {_ in 
                
            }
        }
        .onAppear {
            interactor.updateTheme()
        }
    }
}

// MARK: - Inputing

extension EditRecurrenceView: EditRecurrenceInputing {
    func didChangeValue(to value: String) {
        let request = EditRecurrence.ValidateValue.Request(value: value)
        interactor.didChangeValue(with: request)
    }
    
    func prepareRouteToSheet() {
        interactor.prepareRouteToSheet()
    }
    
    func prepareRouteToOtherScene() {
        interactor.prepareRouteToOtherScene()
    }
}

struct EditRecurrence_Previews: PreviewProvider {
    static var previews: some View {
        EditRecurrence.Scene().view
    }
}
