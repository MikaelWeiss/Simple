//
//  EditTaskView.swift
//  Simple
//
//  Created by Mikael Weiss on 2/13/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

protocol EditTaskInputting {
    func didChangeValue(to value: String)
    func prepareRouteToSheet()
    func prepareRouteToOtherScene()
}

struct EditTaskView: View {
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
                TextEntry(viewModel.nameCellTitle, value: viewModel.nameCellValue) {
                    didChangeValue(to: $0)
                }
                DateSelection("Date", value: Date()) {
                    didChangeDate(to: $0)
                }
                RepetitionSelectionCell(viewModel.repetitionCellTitle,
                                        repetitionOptions: viewModel.repetitions,
                                        selectedRepetition: viewModel.selectedRepetition) {
                    didChangeRepetition(to: $0)
                }
            }
            .padding(.horizontal)
        }
        .onAppear {
            interactor?.updateTheme()
        }
        .navigationBarTitle(viewModel.title)
    }
}

// MARK: - Inputing

extension EditTaskView: EditTaskInputting {
    func didChangeValue(to value: String) {
        let request = EditTask.ValidateName.Request(value: value)
        interactor?.didChangeName(with: request)
    }
    
    func didChangeDate(to date: Date) {
        let request = EditTask.ValidateDate.Request(value: date)
        interactor?.didChangeDate(with: request)
    }
    
    func didChangeRepetition(to repetition: Frequency) {
        let request = EditTask.ValidateRepetitionSelection.Request(selectedRepetition: repetition)
        interactor?.didChangeRepetition(with: request)
    }
    
    func prepareRouteToSheet() {
        interactor?.prepareRouteToSheet()
    }
    
    func prepareRouteToOtherScene() {
        interactor?.prepareRouteToOtherScene()
    }
}

struct EditTask_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            return EditTaskView(viewModel:
                                    EditTask.ViewModel(
                                        title: "New Task",
                                        nameCellTitle: "Name",
                                        nameCellValue: "",
                                        dateCellTitle: "Date:",
                                        dateCellValue: Date.now,
                                        repetitionCellTitle: "Repetition:",
                                        selectedRepetition: .daily,
                                        repetitions: Frequency.allCases,
                                        isShowingOtherScene: false,
                                        isShowingSheet: false)
            )
        }
    }
}


// MARK: - Other Views

struct RepetitionSelectionCell: View {
    @State private var isShowingSelectionSheet = false
    
    let title: String
    let repetitionOptions: [Frequency]
    let selectedRepetition: Frequency?
    let onSelectedRepetition: (Frequency) -> Void
    
    init(_ title: String,
         repetitionOptions: [Frequency],
         selectedRepetition: Frequency?,
         onSelectedRepetition: @escaping (Frequency) -> Void) {
        self.title = title
        self.repetitionOptions = repetitionOptions
        self.selectedRepetition = selectedRepetition
        self.onSelectedRepetition = onSelectedRepetition
    }
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
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
                repetitionOptions: repetitionOptions,
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
        }
    }
}
