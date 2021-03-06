//
//  CustomRecurrenceView.swift
//  Simple
//
//  Created by Mikael Weiss on 3/6/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

protocol CustomRecurrenceInputting {
    func selectedFrequency(_ frequency: CustomRecurrence.Frequency)
    func selectedInterval(_ interval: Int)
}

struct CustomRecurrenceView: View {
    @ObservedObject private var viewModel: CustomRecurrence.ViewModel
    private let interactor: CustomRecurrenceRequesting?
    
    init(interactor: CustomRecurrenceRequesting?, viewModel: CustomRecurrence.ViewModel) {
        self.interactor = interactor
        self.viewModel = viewModel
    }
    
    // MARK: - View Lifecycle
    var body: some View {
        return List {
            FrequencySection()
            { frequency in
                selectedFrequency(frequency)
            } onSelectedInterval: { interval in
                selectedInterval(interval)
            }
            .animation(.none)
        }
        .animation(.easeIn)
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(viewModel.sceneTitle)
    }
}

extension CustomRecurrence {
    enum Frequency: String, CaseIterable {
        case hourly = "Hourly"
        case daily = "Daily"
        case weekly = "Weekly"
        case monthly = "Monthly"
        case yearly = "Yearly"
    }
}

// MARK: - Inputing

extension CustomRecurrenceView: CustomRecurrenceInputting {
    func selectedFrequency(_ frequency: CustomRecurrence.Frequency) {
        let request = CustomRecurrence.SelectedFrequency.Request(value: frequency)
        interactor?.didSelectFrequency(with: request)
    }
    
    func selectedInterval(_ interval: Int) {
        
    }
}

// MARK: - Other views

extension CustomRecurrenceView {
    
    struct FrequencySection: View {
        
        @State private var showingFrequencySelection = false
        @State private var showingIntervalSelection = false
        @State private var frequency: CustomRecurrence.Frequency = .daily
        @State private var interval: Int = 1
        let onSelectedFrequency: (CustomRecurrence.Frequency) -> Void
        let onSelectedInterval: (Int) -> Void
        
        var body: some View {
            Section {
                HStack {
                    Text("Frequency")
                    Spacer()
                    Text(frequency.rawValue)
                        .opacity(0.5)
                }
                .wrapInPlainButton { showingFrequencySelection.toggle() }
                
                if showingFrequencySelection {
                    Picker("Frequency", selection: $frequency) {
                        ForEach(CustomRecurrence.Frequency.allCases, id: \.self) { frequency in
                            Text(frequency.rawValue)
                        }
                    }
                    .pickerStyle(InlinePickerStyle())
                    .animation(.none)
                }
                
                HStack {
                    Text("Every")
                    Spacer()
                    Text(CustomRecurrenceView.string(for: frequency, given: interval))
                        .opacity(0.5)
                }
                .wrapInPlainButton { showingIntervalSelection.toggle() }
                
                if showingIntervalSelection {
                    Picker("Frequency", selection: $interval) {
                        ForEach(1 ... 24, id: \.self) { interval in
                            Text("\(interval)")
                        }
                    }
                    .pickerStyle(InlinePickerStyle())
                }
            }
        }
    }
    
    static func string(for frequency: CustomRecurrence.Frequency, given int: Int) -> String {
        switch frequency {
        case .hourly: return int == 1 ? "Hour" : "\(int) hours"
        case .daily: return int == 1 ? "Day" : "\(int) days"
        case .weekly: return int == 1 ? "Week" : "\(int) weeks"
        case .monthly: return int == 1 ? "Month" : "\(int) months"
        case .yearly: return int == 1 ? "Year" : "\(int) years"
        }
    }
}

// MARK: - Previews
struct CustomRecurrence_Previews: PreviewProvider {
    
    static var vm: CustomRecurrence.ViewModel {
        let vm = CustomRecurrence.ViewModel()
        return vm
    }
    
    static var previews: some View {
        NavigationView {
            CustomRecurrenceView(interactor: nil, viewModel: vm)
        }
    }
}
