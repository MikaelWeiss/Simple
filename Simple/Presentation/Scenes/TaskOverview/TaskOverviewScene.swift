//
//  TaskOverviewScene.swift
//  Simple
//
//  Created by Mikael Weiss on 2/12/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum TaskOverview {
    struct Scene {
        let view: TaskOverviewView
        
        init() {
            let service = TaskOverview.Service()
            let presenter = TaskOverviewPresenter()
            let interactor = TaskOverviewInteractor(service: service, presenter: presenter)
            view = TaskOverviewView(interactor: interactor, viewModel: presenter.viewModel)
        }
        
        private func buildService() -> TaskOverviewService {
            if true {
                return TaskOverview.DemoService()
            }
        }
        
        let service = TaskOverview.Service()
    }
}
