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
    func selectedDayOfTheWeek(_ day: WeeklyRecurrence.DayOfTheWeek)
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
            FrequencySection(
                frequency: viewModel.selectedFrequency,
                interval: viewModel.selectedInterval,
                onUpdatedFrequency: { frequency in
                    selectedFrequency(frequency)
                },
                onUpdatedInterval: { interval in
                    selectedInterval(interval)
                })
            .animation(.none)
            
            if viewModel.selectedFrequency == .weekly {
                DaysOfTheWeekView(selectedDays: viewModel.selectedDaysOfTheWeek) { day in
                    selectedDayOfTheWeek(day)
                }
            }
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
        let request = CustomRecurrence.SelectedInterval.Request(value: interval)
        interactor?.didSelectInterval(with: request)
    }
    
    func selectedDayOfTheWeek(_ day: WeeklyRecurrence.DayOfTheWeek) {
        let request = CustomRecurrence.SelectedDayOfTheWeek.Request(value: day)
        interactor?.didSelectDayOfTheWeek(with: request)
    }
}

// MARK: - Other views

extension CustomRecurrenceView {
    
    struct FrequencySection: View {
        @State private var showingFrequencySelection = false
        @State private var showingIntervalSelection = false
        let frequency: CustomRecurrence.Frequency
        let interval: Int
        let onUpdatedFrequency: (CustomRecurrence.Frequency) -> Void
        let onUpdatedInterval: (Int) -> Void
        
        var body: some View {
            let frequencyBinding = Binding<CustomRecurrence.Frequency> (
                get: { frequency },
                set: { onUpdatedFrequency($0) }
            )
            let intervalBinding = Binding<Int> (
                get: { interval },
                set: { onUpdatedInterval($0) }
            )

            Section {
                HStack {
                    Text("Frequency")
                    Spacer()
                    Text(frequency.rawValue)
                        .opacity(0.5)
                }
                .wrapInPlainButton { showingFrequencySelection.toggle() }
                
                if showingFrequencySelection {
                    Picker("Frequency", selection: frequencyBinding) {
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
                    Picker("Frequency", selection: intervalBinding) {
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
    
    struct DaysOfTheWeekView: View {
        let selectedDays: Set<WeeklyRecurrence.DayOfTheWeek>
        let onSelectedDay: (WeeklyRecurrence.DayOfTheWeek) -> Void
        
        var body: some View {
            Section {
                ForEach(WeeklyRecurrence.DayOfTheWeek.allCases, id: \.self) { dayOfTheWeek in
                    HStack {
                        Text(PresentationSupport.string(for: dayOfTheWeek))
                        Spacer()
                        if selectedDays.contains(dayOfTheWeek) {
                            Image(systemName: "checkmark")
                                .foregroundColor(.accentColor)
                        }
                    }
                    .wrapInPlainButton { }
                }
            }
        }
    }
}

// MARK: - Previews
struct CustomRecurrence_Previews: PreviewProvider {
    
    static var vm: CustomRecurrence.ViewModel {
        let vm = CustomRecurrence.ViewModel()
        vm.selectedFrequency = .weekly
        return vm
    }
    
    static var previews: some View {
        NavigationView {
            CustomRecurrenceView(interactor: nil, viewModel: vm)
        }
    }
}
