//
//  EditRecurrenceModels.swift
//  Simple
//
//  Created by Mikael Weiss on 3/5/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit

extension EditRecurrence {
    enum ValidateValue {
        struct Request {
            let value: String
        }
        
        struct Response {
            let value: String
        }
    }
    
    enum Strings {
        static let sceneTitle = NSLocalizedString("Some title", comment: "The title for the scene")
        static let textFieldTitle = NSLocalizedString("Some title", comment: "The title for some text field")
    }
    
    class ViewModel: ObservableObject {
        @Published var title = ""
        @Published var textFieldTitle = ""
        @Published var textFieldValue = ""
        @Published var isShowingOtherScene = false
        @Published var sheetShowing = false
    }
}