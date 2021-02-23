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
    
    enum ValidateRepetitionSelection {
        struct Request {
            let selectedRepetition: Frequency
        }
        
        struct Response {
            let selectedRepetition: Frequency
        }
    }
    
    enum Strings {
        static let sceneTitle = NSLocalizedString("New Task", comment: "The title for the scene")
        static let nameCellTitle = NSLocalizedString("Name", comment: "Cell title for task name text entry")
        static let dateCellTitle = NSLocalizedString("Date:", comment: "Cell title for task date entry")
        static let repetitionCellTitle = NSLocalizedString("Repetition:", comment: "Cell title for task repetition")
    }
    
    class ViewModel: ObservableObject {
        @Published var title: String
        @Published var nameCellTitle: String
        @Published var nameCellValue: String
        @Published var dateCellTitle: String
        @Published var dateCellValue: Date
        @Published var repetitionCellTitle: String
        @Published var selectedRepetition: Frequency?
        @Published var repetitions: [Frequency]
        @Published var isShowingOtherScene: Bool
        @Published var isShowingSheet: Bool
        
        init(title: String = "",
             nameCellTitle: String = "",
             nameCellValue: String = "",
             dateCellTitle: String = "",
             dateCellValue: Date = Date.now,
             repetitionCellTitle: String = "",
             selectedRepetition: Frequency? = nil,
             repetitions: [Frequency] = [.daily],
             isShowingOtherScene: Bool = false,
             isShowingSheet: Bool = false) {
            
            self.title = title
            self.nameCellTitle = nameCellTitle
            self.nameCellValue = nameCellValue
            self.dateCellTitle = dateCellTitle
            self.dateCellValue = dateCellValue
            self.repetitionCellTitle = repetitionCellTitle
            self.selectedRepetition = selectedRepetition
            self.repetitions = repetitions
            self.isShowingOtherScene = isShowingOtherScene
            self.isShowingSheet = isShowingSheet
        }
    }
}
