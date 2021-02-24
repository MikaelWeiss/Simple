//
//  EditTaskModels.swift
//  Simple
//
//  Created by Mikael Weiss on 2/13/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit

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
    
    enum ValidateFrequencySelection {
        struct Request {
            let selectedFrequency: Frequency
        }
        
        struct Response {
            let selectedFrequency: Frequency
        }
    }
    
    enum CanSave {
        struct Response {
            let canSave: Bool
        }
    }
    
    enum ShowError {
        struct Response {
            let error: ServiceError
        }
    }
    
    enum Strings {
        static let sceneTitle = NSLocalizedString("New Task", comment: "The title for the scene")
        static let nameCellTitle = NSLocalizedString("Name", comment: "Cell title for task name text entry")
        static let dateCellTitle = NSLocalizedString("Date:", comment: "Cell title for task date entry")
        static let frequencyCellTitle = NSLocalizedString("Repetition:", comment: "Cell title for task repetition")
        static let saveFailedAlertTitle = NSLocalizedString("Save failed", comment: "The title for the save failed alert")
        static let saveFailedAlertMessage = NSLocalizedString("We were unable to save your tasks", comment: "The message for the save failed alert")
        static let defaultAlertActionTitle = NSLocalizedString("OK", comment: "The default alert action title")
        static let unknownErrorAlertTitle = NSLocalizedString("Unknown Error", comment: "unknown error alert title")
        static let unknownErrorAlertMessage = NSLocalizedString("Something unexpected happened", comment: "unknown error alert message")
    }
    
    class ViewModel: ObservableObject {
        @Published var title: String
        @Published var nameTitle: String
        @Published var name: String
        @Published var preferredTimeTitle: String
        @Published var preferredTime: Date
        @Published var frequencyTitle: String
        @Published var selectedFrequency: Frequency
        @Published var taskImage: UIImage?
        @Published var canSave: Bool
        @Published var alertInfo: (title: String, message: String, actionTitle: String)
        @Published var isShowingAlert: Bool
        
        init(title: String = "",
             nameTitle: String = "",
             name: String = "",
             preferredTimeTitle: String = "",
             preferredTime: Date = Date.now,
             frequencyTitle: String = "",
             selectedFrequency: Frequency = .daily,
             taskImage: UIImage? = nil,
             canSave: Bool = false,
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
            self.name = name
            self.preferredTimeTitle = preferredTimeTitle
            self.preferredTime = preferredTime
            self.frequencyTitle = frequencyTitle
            self.selectedFrequency = selectedFrequency
            self.taskImage = taskImage
            self.canSave = canSave
            self.alertInfo = alertInfo
            self.isShowingAlert = isShowingAlert
        }
    }
}
