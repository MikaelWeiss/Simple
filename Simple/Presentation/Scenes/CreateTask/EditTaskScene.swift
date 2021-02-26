//
//  EditTaskScene.swift
//  Simple
//
//  Created by Mikael Weiss on 2/13/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum EditTask {
    
    struct Input {
        var taskID: UUID
    }
    
    static var input: Input?
    
    struct Scene {
        let view: EditTaskView
        
        init() {
            let service = EditTask.Service(
                taskID: EditTask.input?.taskID,
                taskRepository: RepositoryRoot.shared.taskRepository)
            let presenter = EditTaskPresenter()
            let interactor = EditTaskInteractor(service: service, presenter: presenter)
            view = EditTaskView(interactor: interactor, viewModel: presenter.viewModel)
            EditTask.input = nil
        }
    }
}
