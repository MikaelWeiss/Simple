//
//  TaskOverviewView.swift
//  Simple
//
//  Created by Mikael Weiss on 2/12/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

protocol TaskOverviewInputting {
    func didChangeValue(to value: String)
    func prepareRouteToSheet()
    func prepareRouteToOtherScene()
}

struct TaskOverviewView: View {
    @ObservedObject private var viewModel: TaskOverview.ViewModel
    private let interactor: TaskOverviewRequesting
    
    init(interactor: TaskOverviewRequesting, viewModel: TaskOverview.ViewModel) {
        self.interactor = interactor
        self.viewModel = viewModel
    }
    
    // MARK: - View Lifecycle
    var body: some View {
        Text("Sup")
    }
}

// MARK: - Inputing

extension TaskOverviewView: TaskOverviewInputting {
    func didChangeValue(to value: String) {
        let request = TaskOverview.ValidateValue.Request(value: value)
        interactor.didChangeValue(with: request)
    }
    
    func prepareRouteToSheet() {
        interactor.prepareRouteToSheet()
    }
    
    func prepareRouteToOtherScene() {
        interactor.prepareRouteToOtherScene()
    }
}

struct TaskOverview_Previews: PreviewProvider {
    static var previews: some View {
        TaskOverview.Scene().view
    }
}
