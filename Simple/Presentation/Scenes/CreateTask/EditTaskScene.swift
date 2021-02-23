//
//  EditTaskScene.swift
//  Simple
//
//  Created by Mikael Weiss on 2/13/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum EditTask {
    
    struct SceneInfo {
        let task: Task?
    }
    
    struct Scene {
        let view: EditTaskView
        
        init(sceneInfo: SceneInfo = SceneInfo(task: nil)) {
            let service = EditTask.Service(task: sceneInfo.task)
            let presenter = EditTaskPresenter()
            let interactor = EditTaskInteractor(service: service, presenter: presenter)
            view = EditTaskView(interactor: interactor, viewModel: presenter.viewModel)
        }
    }
}
