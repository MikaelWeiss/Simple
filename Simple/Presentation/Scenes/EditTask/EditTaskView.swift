//
//  EditTaskView.swift
//  Simple
//
//  Created by Mikael Weiss on 2/13/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI
import Combine

protocol EditTaskInputting {
    func didChangeName(to value: String)
    func didChangeDate(to date: Date)
    func didTapDelete()
    func didTapSave()
}

struct EditTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var viewModel: EditTask.ViewModel
    private let interactor: EditTaskRequesting?
        
    init(interactor: EditTaskRequesting, viewModel: EditTask.ViewModel) {
        self.interactor = interactor
        self.viewModel = viewModel
    }
    
    init(viewModel: EditTask.ViewModel) {
        self.viewModel = viewModel
        self.interactor = nil
    }
    
    // MARK: - View Lifecycle
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Spacer().frame(height: 0)
                TextEntry(viewModel.nameTitle, value: viewModel.nameInfo.value, state: viewModel.nameInfo.state) {
                    didChangeName(to: $0)
                }
                DateSelection("Date", value: viewModel.preferredTime) {
                    didChangeDate(to: $0)
                }
                RecurrenceSelectionCell(viewModel.recurrenceTitle)
                    .wrapInPlainButton {
                        didTapRecurrenceSelection()
                    }
                
                Button("Delete Task") {
                    didTapDelete()
                }
                .disabled(viewModel.canDelete)
            }
            .padding(.horizontal)
        }
        .onAppear {
            interactor?.updateTheme()
            interactor?.fetchTask()
            interactor?.checkCanSave()
        }
        .onReceive(viewModel.$isShowing) { isShowing in
            if !isShowing {
                presentationMode.wrappedValue.dismiss()
            }
        }
        .navigationBarTitle(viewModel.title)
        .navigationBarItems(trailing:
                                Button("Save") {
                                    didTapSave()
                                }
                                .disabled(!viewModel.canSave)
        )
        .alert(isPresented: $viewModel.isShowingAlert) {
            let info = viewModel.alertInfo
            return Alert(
                title: Text(info.title),
                message: Text(info.message),
                dismissButton: .default(Text(info.actionTitle)))
        }
    }
}

// MARK: - Inputing

extension EditTaskView: EditTaskInputting {
    func didChangeName(to value: String) {
        let request = EditTask.ValidateName.Request(value: value)
        interactor?.didChangeName(with: request)
        interactor?.checkCanSave()
    }
    
    func didChangeDate(to date: Date) {
        let request = EditTask.ValidateDate.Request(value: date)
        interactor?.didChangeDate(with: request)
        interactor?.checkCanSave()
    }
    
//    func didChangeFrequency(to frequency: Frequency) {
//        let request = EditTask.ValidateFrequencySelection.Request(selectedFrequency: frequency)
//        interactor?.didChangeFrequency(with: request)
//        interactor?.checkCanSave()
//    }
    
    func didTapRecurrenceSelection() {
        interactor?.didTapRecurrenceSelection()
    }
    
    func didTapDelete() {
        interactor?.didTapDelete()
    }
    
    func didTapSave() {
        interactor?.didTapSave()
    }
}

struct EditTask_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EditTaskView(viewModel:
                                    EditTask.ViewModel(
                                        title: "New Task",
                                        nameTitle: "Name",
                                        nameInfo: .init(value: "", state: .normal),
                                        preferredTimeTitle: "Date:",
                                        preferredTime: Date.now,
                                        frequencyTitle: "Repetition:"))
        }
    }
}


// MARK: - Other Views

struct RecurrenceSelectionCell: View {
    private let title: String
    
    init(_ title: String) {
        self.title = title
    }
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text("Select Value")
                .fontWeight(.medium)
                .lineLimit(1)
            Image(systemName: "chevron.right")
                .font(.system(size: 18, weight: .medium, design: .rounded))
        }
        .valueFontStyle()
        .cellStyle()
    }
}
