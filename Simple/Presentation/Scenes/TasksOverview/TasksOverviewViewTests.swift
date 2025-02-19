//
//  TasksOverviewViewTests.swift
//  Simple
//
//  Created by Mikael Weiss on 2/12/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import Simple

class TasksOverviewViewTests: XCTestCase {
    private var interactor: TasksOverviewInteractorDouble!
    private var viewModel: TasksOverview.ViewModel!
    private var view: TasksOverviewView!
    
    // MARK: - Test Setup
    
    override func setUp() {
        super.setUp()
        interactor = TasksOverviewInteractorDouble()
        viewModel = TasksOverview.ViewModel()
        view = TasksOverviewView(interactor: interactor, viewModel: viewModel)
    }
    
    // MARK: - Test Doubles
    
    class TasksOverviewInteractorDouble: TasksOverviewRequesting {
        
        var value: String?
        var updateThemeCalled = false
        var prepareRouteToSheetCalled = false
        var prepareRouteToOtherSceneCalled = false
        var fetchTasksCalled = false
        
        func updateTheme() {
            updateThemeCalled = true
        }
        
        func fetchTasks() {
            fetchTasksCalled = true
        }
        
        func didTapTask(with id: UUID) {
            
        }
        
        func didTapAddTask() {
            
        }
    }
}
