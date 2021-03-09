//
//  EditRecurrenceModels.swift
//  Simple
//
//  Created by Mikael Weiss on 3/5/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

extension EditRecurrence {
    
    enum DidTapDefaultRecurrence {
        struct Request {
            let recurrence: DefaultRecurrence
        }
        struct Response {
            let recurrence: DefaultRecurrence
        }
    }
    
    enum Strings {
        static let sceneTitle = NSLocalizedString("Repeat", comment: "The title for the scene")
    }
    
    class ViewModel: ObservableObject {
        @Published var sceneTitle = Strings.sceneTitle
        @Published var isShowingCustomRepeat = false
        @Published var selectedDefaultRecurrence: DefaultRecurrence? = nil
        @Binding var isShowing: Bool
        
        init(isShowing: Binding<Bool>) {
            self._isShowing = isShowing
        }
    }
}
