//
//  EditTaskModels.swift
//  Simple
//
//  Created by Mikael Weiss on 2/13/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

extension EditTask {
    
    enum FetchRepetition {
        struct Response {
            let repetitions: [Frequency]
        }
    }
    
    enum FetchTask {
        struct Response {
            let task: TaskInfo
        }
    }
    
    enum ValidateName {
        struct Request {
            let value: String
        }
        
        struct Response {
            let value: String
            let valid: Bool
        }
        
        struct TaskInfo {
            let value: String
            let state: TextEntry.ValueState
        }
    }
    
    enum ValidateDate {
        struct Request {
            let value: Date
        }
        
        struct Response {
            let value: Date
        }
    }
    
//    enum ValidateFrequencySelection {
//        struct Request {
//            let selectedFrequency: Frequency
//        }
//        
//        struct Response {
//            let selectedFrequency: Frequency
//        }
//    }
    
    enum CanSave {
        struct Response {
            let canSave: Bool
        }
    }
    
    enum DidTapSave {
        struct Response {
            let didSave: Bool
        }
    }
    
    enum DidTapDelete {
        struct Response {
            let didDelete: Bool
        }
    }
    
    enum ShowError {
        struct Response {
            let error: ServiceError
        }
    }
    
    enum Strings {
        static let editSceneTitle = NSLocalizedString("EditTask-editSceneTitle", comment: "EditTask - Scene title - edit")
        static let creationSceneTitle = NSLocalizedString("EditTask-creationSceneTitle", comment: "EditTask - Scene title - create")
        
        static let nameCellTitle = NSLocalizedString("EditTask-nameCellTitle", comment: "EditTask - Cell title for task name text entry")
        static let dateCellTitle = NSLocalizedString("EditTask-dateCellTitle", comment: "EditTask - Cell title for task date entry")
        static let frequencyCellTitle = NSLocalizedString("EditTask-frequencyCellTitle", comment: "EditTask - Cell title for task repetition")
        
        static let saveFailedAlertTitle = NSLocalizedString("EditTask-saveFailedAlertTitle", comment: "EditTask - The title for the save failed alert")
        static let saveFailedAlertMessage = NSLocalizedString("EditTask-saveFailedAlertMessage", comment: "EditTask - The message for the save failed alert")
        
        static let comingSoonAlertTitle = NSLocalizedString("EditTask-comingSoonAlertTitle", comment: "EditTask - The title for the coming soon alert") // "Coming Soon!"
        static let comingSoonAlertMessage = NSLocalizedString("EditTask-comingSoonAlertMessage", comment: "EditTask - The message for the coming soon alert") // "Recurrences will soon be added to the app"
        
        static let unknownErrorAlertTitle = NSLocalizedString("EditTask-unknownErrorAlertTitle", comment: "EditTask - Unknown error alert title")
        static let unknownErrorAlertMessage = NSLocalizedString("EditTask-unknownErrorAlertMessage", comment: "EditTask - Unknown error alert message")
        static let defaultAlertActionTitle = NSLocalizedString("EditTask-defaultAlertActionTitle", comment: "EditTask - The default alert action title")
    }
    
    class ViewModel: ObservableObject {
        @Published var title: String
        @Published var nameTitle: String
        @Published var nameInfo: EditTask.ValidateName.TaskInfo
        @Published var preferredTimeTitle: String
        @Published var preferredTime: Date
        @Published var recurrenceTitle: String
        @Published var taskImage: UIImage?
        @Published var canSave: Bool
        @Published var canDelete: Bool
        var alertInfo: (title: String, message: String, actionTitle: String)
        var alert: Alert {
            Alert(title: Text(alertInfo.title), message: Text(alertInfo.message), dismissButton: .default(Text(alertInfo.actionTitle)))
        }
        @Published var isShowingAlert: Bool
        @Published var isShowing: Bool = true
        
        init(title: String = "",
             nameTitle: String = "",
             nameInfo: EditTask.ValidateName.TaskInfo = .init(value: "", state: .normal),
             preferredTimeTitle: String = "",
             preferredTime: Date = Date.now,
             frequencyTitle: String = "",
             taskImage: UIImage? = nil,
             canSave: Bool = false,
             canDelete: Bool = false,
             alertInfo: (
                title: String,
                message: String,
                actionTitle: String) = (
                    title: Strings.unknownErrorAlertTitle,
                    message: Strings.unknownErrorAlertMessage,
                    actionTitle: Strings.defaultAlertActionTitle),
             isShowingAlert: Bool = false) {
            
            self.title = title
            self.nameTitle = nameTitle
            self.nameInfo = nameInfo
            self.preferredTimeTitle = preferredTimeTitle
            self.preferredTime = preferredTime
            self.recurrenceTitle = frequencyTitle
            self.taskImage = taskImage
            self.canSave = canSave
            self.canDelete = canDelete
            self.alertInfo = alertInfo
            self.isShowingAlert = isShowingAlert
        }
    }
}
