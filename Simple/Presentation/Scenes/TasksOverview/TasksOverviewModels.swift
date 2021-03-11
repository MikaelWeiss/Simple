//
//  TasksOverviewModels.swift
//  Simple
//
//  Created by Mikael Weiss on 2/12/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

extension TasksOverview {
    
    struct TaskInfo {
        let id: UUID
        let name: String
        let date: String
        let time: String
        let image: UIImage?
    }
    
    enum FetchTasks {
        struct Response {
            let tasks: [Task]
        }
    }
    
    enum ShowError {
        struct Response {
            let error: ServiceError
        }
    }
    
    enum Strings {
        static let sceneTitle = NSLocalizedString("TasksOverview-sceneTitle", comment: "TasksOverview - The title for the scene")
        static let fetchFailedAlertTitle = NSLocalizedString("TasksOverview-fetchFailedAlertTitle", comment: "TasksOverview - The title for the fetch failed alert")
        static let fetchFailedAlertMessage = NSLocalizedString("TasksOverview-fetchFailedAlertMessage", comment: "TasksOverview - The message for the fetch failed alert")
        static let defaultAlertActionTitle = NSLocalizedString("TasksOverview-defaultAlertActionTitle", comment: "TasksOverview - The default alert action title")
        static let unknownErrorAlertTitle = NSLocalizedString("TasksOverview-unknownErrorAlertTitle", comment: "TasksOverview - Unknown error alert title")
        static let unknownErrorAlertMessage = NSLocalizedString("TasksOverview-unknownErrorAlertMessage", comment: "TasksOverview - Unknown error alert message")
    }
    
    class ViewModel: ObservableObject {
        @Published var title: String
        @Published var allTasks: [TaskInfo]
        @Published var isShowingEditTask: Bool
        @Published var alertInfo: (title: String, message: String, actionTitle: String)
        @Published var isShowingAlert: Bool
        
        init(title: String = "",
             allTasks: [TaskInfo] = [],
             isShowingEditTask: Bool = false,
             alertInfo: (
                title: String,
                message: String,
                actionTitle: String) = (
                    title: Strings.unknownErrorAlertTitle,
                    message: Strings.unknownErrorAlertMessage,
                    actionTitle: Strings.defaultAlertActionTitle),
             isShowingAlert: Bool = false) {
            
            self.title = title
            self.allTasks = allTasks
            self.isShowingEditTask = isShowingEditTask
            self.alertInfo = alertInfo
            self.isShowingAlert = isShowingAlert
        }
    }
}
