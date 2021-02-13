//
//  TaskOverviewView.swift
//  Simple
//
//  Created by Mikael Weiss on 2/12/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

protocol TaskOverviewInputting {
    func prepareRouteToSheet()
    func prepareRouteToOtherScene()
}

struct TaskOverviewView: View {
    @ObservedObject private var viewModel: TaskOverview.ViewModel
    private let interactor: TaskOverviewRequesting?
    
    init(interactor: TaskOverviewRequesting, viewModel: TaskOverview.ViewModel) {
        self.interactor = interactor
        self.viewModel = viewModel
    }
    
    init(viewModel: TaskOverview.ViewModel) {
        self.viewModel = viewModel
        self.interactor = nil
    }
    
    // MARK: - View Lifecycle
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(0 ..< viewModel.allTasks.count) { index in
                    let item = viewModel.allTasks[index]
                    HStack(alignment: .center, spacing: 0) {
                        if let image = item.image {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Circle())
                                .frame(width: 56, height: 56)
                                .padding(.trailing)
                        } else {
                            Circle()
                                .frame(width: 56, height: 56)
                                .padding(.trailing)
                                .foregroundColor(.blue)
                        }
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.system(.title2, design: .rounded))
                                Text(item.date)
                                    .font(.system(.subheadline, design: .rounded))
                            }
                            Spacer()
                            Text(item.time ?? "")
                                .font(.system(size: 25, weight: .regular, design: .rounded))
                        }
                        Spacer()
                    }
                    .padding()
                    .background(Color(#colorLiteral(red: 0, green: 0.5936935321, blue: 1, alpha: 1)))
                    .clipShape(
                        RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                    )
                    .padding(.horizontal)
                }
            }
        }
        .navigationTitle(viewModel.title)
    }
}

// MARK: - Inputing

extension TaskOverviewView: TaskOverviewInputting {
    func prepareRouteToSheet() {
        interactor?.prepareRouteToSheet()
    }
    
    func prepareRouteToOtherScene() {
        interactor?.prepareRouteToOtherScene()
    }
}

struct TaskOverview_Previews: PreviewProvider {
    static var viewModel = TaskOverview.ViewModel(
        title: "Some title",
        allTasks: [
            .init(name: "Wake up", date: "Today", time: "10:45", image: Image(uiImage: #imageLiteral(resourceName: "testingImage"))),
            .init(name: "Wake up", date: "Dec 12, 2020", time: "12:30", image: nil)
        ])
    
    static var previews: some View {
        NavigationView {
            TaskOverviewView(viewModel: viewModel)
        }
    }
}
