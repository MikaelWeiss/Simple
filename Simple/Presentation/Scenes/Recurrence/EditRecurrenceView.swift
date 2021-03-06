//
//  EditRecurrenceView.swift
//  Simple
//
//  Created by Mikael Weiss on 3/5/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

protocol EditRecurrenceInputing {
    func didTapDefaultRecurrence(_ recurrence: Recurrence.DefaultRecurrence)
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
            DefaultRecurrenceSection(selectedRecurrence: viewModel.selectedDefaultRecurrence) {
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
            interactor?.updateTheme()
        }
    }
}

// MARK: - Inputing

extension EditRecurrenceView: EditRecurrenceInputing {
    func didTapDefaultRecurrence(_ recurrence: Recurrence.DefaultRecurrence) {
        let request = EditRecurrence.DidTapDefaultRecurrence.Request(recurrence: recurrence)
        interactor?.didTapDefaultRecurrence(with: request)
    }
    
    func didTapCustomRepeate() {
        interactor?.didTapCustomRepeat()
    }
}

// MARK: - Other views

extension EditRecurrenceView {
    struct DefaultRecurrenceSection: View {
        let selectedRecurrence: Recurrence.DefaultRecurrence?
        let didTapRecurrence: (Recurrence.DefaultRecurrence) -> Void
        
        var body: some View {
            Section {
                ForEach( 0 ..< Recurrence.DefaultRecurrence.allCases.count) { i in
                    let recurrence = Recurrence.DefaultRecurrence.allCases[i]
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            Text(stringForDefaultRecurrence(recurrence))
                            Spacer()
                                .frame(height: 40)
                            if selectedRecurrence == recurrence {
                                Image(systemName: "checkmark")
                            }
                        }
                        .foregroundColor(Color(.lightGray))
                    }
                    .wrapInPlainButton { didTapRecurrence(recurrence) }
                }
            }
        }
    }
}

private func stringForDefaultRecurrence(_ recurrence: Recurrence.DefaultRecurrence) -> String {
    switch recurrence {
    case .never: return "Never"
    case .hourly: return "Hourly"
    case .daily: return "Daily"
    case .weekly: return "Weekly"
    case .biweekly: return "Biweekly"
    case .monthly: return "Monthly"
    case .everyThreeMonths: return "Every 3 Months"
    case .everySixMonths: return "Every 6 Months"
    case .yearly: return "Yearly"
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
        vm.selectedDefaultRecurrence = .daily
        return vm
    }
    static var previews: some View {
        NavigationView {
            EditRecurrenceView(interactor: nil, viewModel: vm)
        }
    }
}
