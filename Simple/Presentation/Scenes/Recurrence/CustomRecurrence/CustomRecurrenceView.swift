//
//  CustomRecurrenceView.swift
//  Simple
//
//  Created by Mikael Weiss on 3/6/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

protocol CustomRecurrenceInputting {
    func didChangeValue(to value: String)
    func prepareRouteToSheet()
    func prepareRouteToOtherScene()
}

struct CustomRecurrenceView: View {
    @ObservedObject private var viewModel: CustomRecurrence.ViewModel
    private let interactor: CustomRecurrenceRequesting
    @State private var showingFrequencySelection = false
    
    init(interactor: CustomRecurrenceRequesting, viewModel: CustomRecurrence.ViewModel) {
        self.interactor = interactor
        self.viewModel = viewModel
    }
    
    // MARK: - View Lifecycle
    var body: some View {
        List {
            Section {
                HStack {
                    Text("Frequency")
                    Spacer()
                    Text("Monthly")
                        .opacity(0.5)
                }
                .wrapInPlainButton { showingFrequencySelection.toggle() }
                
                if showingFrequencySelection {
                    Text("asdf")
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .onAppear {
            interactor.updateTheme()
        }
    }
}

// MARK: - Inputing

extension CustomRecurrenceView: CustomRecurrenceInputting {
    func didChangeValue(to value: String) {
        let request = CustomRecurrence.ValidateValue.Request(value: value)
        interactor.didChangeValue(with: request)
    }
    
    func prepareRouteToSheet() {
        interactor.prepareRouteToSheet()
    }
    
    func prepareRouteToOtherScene() {
        interactor.prepareRouteToOtherScene()
    }
}

struct CustomRecurrence_Previews: PreviewProvider {
    static var previews: some View {
        CustomRecurrence.Scene().view
    }
}
