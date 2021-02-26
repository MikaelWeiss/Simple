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
                TextEntry(viewModel.nameTitle, value: viewModel.name) {
                    didChangeName(to: $0)
                }
                DateSelection("Date", value: Date()) {
                    didChangeDate(to: $0)
                }
                RepetitionSelectionCell(viewModel.frequencyTitle,
                                        selectedRepetition: viewModel.selectedFrequency) {
                    didChangeFrequency(to: $0)
                }
                Button("Delete Task") {
                    didTapDelete()
                }
//                .disabled(true)
            }
            .padding(.horizontal)
        }
        .onAppear {
            interactor?.updateTheme()
            interactor?.fetchTask()
            interactor?.checkCanSave()
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
        .onReceive(viewModel.$isShowing) { isShowing in
            if !isShowing {
                presentationMode.wrappedValue.dismiss()
            }
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
    
    func didChangeFrequency(to frequency: Frequency) {
        let request = EditTask.ValidateFrequencySelection.Request(selectedFrequency: frequency)
        interactor?.didChangeFrequency(with: request)
        interactor?.checkCanSave()
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
                                        name: "",
                                        preferredTimeTitle: "Date:",
                                        preferredTime: Date.now,
                                        frequencyTitle: "Repetition:",
                                        selectedFrequency: .daily))
        }
    }
}


// MARK: - Other Views

struct RepetitionSelectionCell: View {
    @State private var isShowingSelectionSheet = false
    
    private let frequencyOptions: [Frequency] = Frequency.allCases
    let title: String
    let selectedRepetition: Frequency?
    let onSelectedRepetition: (Frequency) -> Void
    
    init(_ title: String,
         selectedRepetition: Frequency?,
         onSelectedRepetition: @escaping (Frequency) -> Void) {
        self.title = title
        self.selectedRepetition = selectedRepetition
        self.onSelectedRepetition = onSelectedRepetition
    }
    
    var body: some View {
        HStack {
            Text(title)
            Spacer().tappable()
            Text(selectedRepetition?.stringValue.capitalized ?? "Select Value")
                .valueFontStyle()
                .lineLimit(1)
            Image(systemName: "arrowtriangle.down.square.fill")
                .valueFontStyle()
        }
        .valueFontStyle()
        .cellStyle()
        .onTapGesture {
            isShowingSelectionSheet = true
        }
        .sheet(isPresented: $isShowingSelectionSheet) {
            SelectRepetitionView(
                repetitionOptions: frequencyOptions,
                currentlySelectedRepetition: selectedRepetition) {
                onSelectedRepetition($0)
            }
        }
    }
}

struct SelectRepetitionView: View {
    @Environment(\.presentationMode) var presentationMode
    let repetitionOptions: [Frequency]
    let onSelectedRepetition: (Frequency) -> Void
    let currentlySelectedRepetition: Frequency?
    
    init(repetitionOptions: [Frequency],
         currentlySelectedRepetition: Frequency?,
         onSelectedRepetition: @escaping (Frequency) -> Void) {
        self.repetitionOptions = repetitionOptions
        self.currentlySelectedRepetition = currentlySelectedRepetition
        self.onSelectedRepetition = onSelectedRepetition
    }
    
    var body: some View {
        ScrollView {
            ForEach(0 ..< repetitionOptions.count) { index in
                let repetition = repetitionOptions[index]
                
                HStack {
                    Image(systemName: repetition == currentlySelectedRepetition ? "circle.fill" : "circle")
                    Text("\(repetition.stringValue.capitalized)")
                    Spacer()
                }
                .padding(.vertical, 5)
                .valueFontStyle()
                .onTapGesture {
                    self.onSelectedRepetition(repetition)
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .cellStyle()
            .padding()
        }
    }
}
