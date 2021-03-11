//
//  EditRecurrenceView.swift
//  Simple
//
//  Created by Mikael Weiss on 3/5/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

protocol EditRecurrenceInputing {
    func didTapDefaultRecurrence(_ recurrence: EditRecurrence.DefaultRecurrence)
    func didTapCustomRepeate()
}

struct EditRecurrenceView: View {
    @ObservedObject private var viewModel: EditRecurrence.ViewModel
    private let interactor: EditRecurrenceRequesting?
    
    init(interactor: EditRecurrenceRequesting?, viewModel: EditRecurrence.ViewModel) {
        self.interactor = interactor
        self.viewModel = viewModel
    }
    
    // MARK: - View Lifecycle
    var body: some View {
        List {
            DefaultRecurrenceSection(recurrences: viewModel.defaultRecurrences) {
                didTapDefaultRecurrence($0)
            }
            
            CustomRepeatSection(isShowingCustomRepeat: $viewModel.isShowingCustomRepeat)
                .onTapGesture {
                    didTapCustomRepeate()
                }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle(viewModel.sceneTitle, displayMode: .inline)
        
        .onAppear {
            interactor?.setup()
        }
    }
}

// MARK: - Inputing

extension EditRecurrenceView: EditRecurrenceInputing {
    func didTapDefaultRecurrence(_ recurrence: EditRecurrence.DefaultRecurrence) {
        let request = EditRecurrence.DidSelectDefaultRecurrence.Request(recurrence: recurrence)
        interactor?.didTapDefaultRecurrence(with: request)
    }
    
    func didTapCustomRepeate() {
        interactor?.didTapCustomRepeat()
    }
}

// MARK: - Other views

extension EditRecurrenceView {
    struct DefaultRecurrenceSection: View {
        let recurrences: [EditRecurrence.DidSelectDefaultRecurrence.Cell]
        let didTapRecurrence: (EditRecurrence.DefaultRecurrence) -> Void
        
        var body: some View {
            Section {
                ForEach(recurrences) { cell in
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            Text(cell.value)
                            Spacer()
                                .frame(height: 40)
                            if cell.selected {
                                Image(systemName: "checkmark")
                            }
                        }
                        .foregroundColor(Color(.lightGray))
                    }
                    .wrapInPlainButton { didTapRecurrence(cell.recurrence) }
                }
            }
        }
    }
}

extension EditRecurrenceView {
    struct CustomRepeatSection: View {
        
        @Binding var isShowingCustomRepeat: Bool
        
        var body: some View {
            Section {
                HStack {
                    Text("Custom Repeat")
                }
            }
            .foregroundColor(Color(.lightGray))
            .wrapInNavigationLink(isActive: $isShowingCustomRepeat) {
                CustomRecurrence.Scene().view
            }
        }
    }
}

// MARK: - Previews
struct EditRecurrence_Previews: PreviewProvider {
    
    static var vm: EditRecurrence.ViewModel {
        let vm = EditRecurrence.ViewModel(isShowing: .constant(true))
        vm.defaultRecurrences = .init(cells: [.init(recurrence: .never, value: "Never", selected: false),
                                              .init(recurrence: .daily, value: "Daily", selected: true),
                                              .init(recurrence: .yearly, value: "Yearly", selected: false)])
        return vm
    }
    static var previews: some View {
        NavigationView {
            EditRecurrenceView(interactor: nil, viewModel: vm)
        }
    }
}
