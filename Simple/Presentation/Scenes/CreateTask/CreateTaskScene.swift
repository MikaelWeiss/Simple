//
//  CreateTaskScene.swift
//  Simple
//
//  Created by Mikael Weiss on 2/13/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum CreateTask {
    struct Scene {
        let view: CreateTaskView
        
        init() {
            let service = CreateTask.Service()
            let presenter = CreateTaskPresenter()
            let interactor = CreateTaskInteractor(service: service, presenter: presenter)
            view = CreateTaskView(interactor: interactor, viewModel: presenter.viewModel)
        }
        
        private func buildService() -> CreateTaskService {
            if true {
                return CreateTask.DemoService()
            }
        }
        
        let service = CreateTask.Service()
    }
}
