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
        static let sceneTitle = NSLocalizedString("Overview", comment: "The title for the scene")
        static let fetchFailedAlertTitle = NSLocalizedString("Fetch failed", comment: "The title for the fetch failed alert")
        static let fetchFailedAlertMessage = NSLocalizedString("We were unable to fetch your tasks", comment: "The message for the fetch failed alert")
        static let defaultAlertActionTitle = NSLocalizedString("OK", comment: "The default alert action title")
        static let unknownErrorAlertTitle = NSLocalizedString("Unknown Error", comment: "unknown error alert title")
        static let unknownErrorAlertMessage = NSLocalizedString("Something unexpected happened", comment: "unknown error alert message")
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
