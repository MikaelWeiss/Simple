//
//  TasksOverviewPresenter.swift
//  Simple
//
//  Created by Mikael Weiss on 2/12/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

protocol TasksOverviewPresenting {
    func presentUpdateTheme()
    func presentFetchTasks(with response: TasksOverview.FetchTasks.Response)
    func presentPrepareRouteToSheet()
    func presentPrepareRouteToOtherScene()
}

struct TasksOverviewPresenter: TasksOverviewPresenting {
    let viewModel = TasksOverview.ViewModel()
    
    func presentUpdateTheme() {
        viewModel.title = TasksOverview.Strings.sceneTitle
    }
    
    func presentFetchTasks(with response: TasksOverview.FetchTasks.Response) {
        let sortedTasks = response.tasks.sorted(by: { $0.preferredTime < $1.preferredTime })
        let mappedTaskList = sortedTasks.map { (task) -> TasksOverview.TaskInfo in
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            let date = formatter.string(from: task.preferredTime)
            formatter.dateStyle = .none
            formatter.timeStyle = .short
            let time = formatter.string(from: task.preferredTime)
            
            return TasksOverview.TaskInfo(name: task.name, date: date, time: time, image: task.image)
        }
        viewModel.allTasks = mappedTaskList
    }
    
    func presentPrepareRouteToSheet() {
        viewModel.isShowingSheet = true
    }
    
    func presentPrepareRouteToOtherScene() {
        viewModel.isShowingOtherScene = true
    }
}
