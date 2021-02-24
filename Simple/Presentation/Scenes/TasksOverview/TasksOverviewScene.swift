//
//  TasksOverviewScene.swift
//  Simple
//
//  Created by Mikael Weiss on 2/12/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

enum TasksOverview {
    struct Scene {
        let view: TasksOverviewView
        
        init() {
            let service = TasksOverview.Service(taskRepository: RepositoryRoot.shared.taskRepository)
            let presenter = TasksOverviewPresenter()
            let interactor = TasksOverviewInteractor(service: service, presenter: presenter)
            view = TasksOverviewView(interactor: interactor, viewModel: presenter.viewModel)
        }
    }
}
