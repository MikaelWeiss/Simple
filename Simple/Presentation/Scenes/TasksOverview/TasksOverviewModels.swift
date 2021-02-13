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
        let image: Image?
    }
    
    struct Task {
        let name: String
        let date: Date
        let image: Image?
    }
    
    enum FetchTasks {
        struct Response {
            let tasks: [Task]
        }
    }
    
    enum Strings {
        static let sceneTitle = NSLocalizedString("Overview", comment: "The title for the scene")
    }
    
    class ViewModel: ObservableObject {
        @Published var title: String
        @Published var allTasks: [TaskInfo]
        @Published var isShowingOtherScene: Bool
        @Published var isShowingSheet: Bool
        
        init(title: String = "",
             allTasks: [TaskInfo] = [],
             isShowingOtherScene: Bool = false,
             isShowingSheet: Bool = false) {
            
            self.title = title
            self.allTasks = allTasks
            self.isShowingOtherScene = isShowingOtherScene
            self.isShowingSheet = isShowingSheet
        }
    }
}
