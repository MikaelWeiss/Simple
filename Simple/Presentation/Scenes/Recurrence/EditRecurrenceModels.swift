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
        struct ViewModel {
            struct Cell {
                let recurrence: DefaultRecurrence
                let value: String
                let selected: Bool
            }
            
            let cells: [Cell]
        }
    }
    
    enum Strings {
        static let sceneTitle = NSLocalizedString("Repeat", comment: "The title for the scene")
    }
    
    class ViewModel: ObservableObject {
        @Published var sceneTitle = Strings.sceneTitle
        @Published var isShowingCustomRepeat = false
        @Published var defaultRecurrences: DidTapDefaultRecurrence.ViewModel = .init(cells: [.init(recurrence: .daily, value: "Daily", selected: false)])
        @Binding var isShowing: Bool
        
        init(isShowing: Binding<Bool>) {
            self._isShowing = isShowing
        }
    }
}
