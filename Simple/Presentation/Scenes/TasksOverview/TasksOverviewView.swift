//
//  TasksOverviewView.swift
//  Simple
//
//  Created by Mikael Weiss on 2/12/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

protocol TasksOverviewInputting {
    func didTapAddTask()
    func didTapTask(with id: UUID)
}

struct TasksOverviewView: View {
    @ObservedObject private var viewModel: TasksOverview.ViewModel
    private let interactor: TasksOverviewRequesting?
    
    init(interactor: TasksOverviewRequesting, viewModel: TasksOverview.ViewModel) {
        self.interactor = interactor
        self.viewModel = viewModel
    }
    
    init(viewModel: TasksOverview.ViewModel) {
        self.viewModel = viewModel
        self.interactor = nil
    }
    
    // MARK: - View Lifecycle
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(0 ..< viewModel.allTasks.count , id: \.self) { index in
                    let item = viewModel.allTasks[index]
                    HStack(alignment: .center, spacing: 0) {
                        if let image = item.image {
                            Image(uiImage: image)
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
                            Text(item.time)
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
                    .onTapGesture {
                        didTapTask(with: item.id)
                    }
                }
            }
        }
        .navigationBarItems(trailing: Button(action: {
            didTapAddTask()
        }, label: {
            Image(systemName: "plus")
                .font(.system(size: 24, weight: .black, design: .rounded))
        }))
        .navigationTitle(viewModel.title)
        .onAppear {
            interactor?.updateTheme()
            interactor?.fetchTasks()
        }
        .sheet(isPresented: $viewModel.isShowingEditTask, content: {
            NavigationView {
                EditTask.Scene().view
            }
        })
        .alert(isPresented: $viewModel.isShowingAlert, content: {
            Alert(title: Text(viewModel.alertInfo.title),
                  message: Text(viewModel.alertInfo.message),
                  dismissButton: .default(Text(viewModel.alertInfo.actionTitle)))
        })
    }
}

// MARK: - Inputing

extension TasksOverviewView: TasksOverviewInputting {
    func didTapAddTask() {
        interactor?.didTapAddTask()
    }
    
    func didTapTask(with id: UUID) {
        interactor?.didTapTask(with: id)
    }
}

struct TasksOverview_Previews: PreviewProvider {
    static var viewModel = TasksOverview.ViewModel(
        title: "Some title",
        allTasks: [
            .init(id: UUID(), name: "Wake up", date: "Today", time: "10:45", image: UIImage(#imageLiteral(resourceName: "testingImage"))),
            .init(id: UUID(), name: "Wake up", date: "Dec 12, 2020", time: "12:30", image: nil)
        ])
    
    static var previews: some View {
        NavigationView {
            TasksOverviewView(viewModel: viewModel)
        }
    }
}
