//
//  TasksOverviewInteractorTests.swift
//  Simple
//
//  Created by Mikael Weiss on 2/12/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import Simple

class TasksOverviewInteractorTests: XCTestCase {
    private var service: TasksOverviewServiceDouble!
    private var presenter: TasksOverviewPresenterDouble!
    private var interactor: TasksOverviewInteractor!
    
    func testUpdateTheme() {
        // When
        interactor.updateTheme()
        
        // Then
        XCTAssertTrue(presenter.presentUpdateThemeCalled)
    }
    
    func testFetchTasks() {
        // Given
        let date = Date()
        service.tasksToReturn = [.init(name: "some name", preferredTime: date, frequency: .daily, image: nil)]
        
        // When
        interactor.fetchTasks()
        
        // Then
        XCTAssertEqual(presenter.presentFetchTasksResponse.tasks.first?.name, "some name")
        XCTAssertEqual(presenter.presentFetchTasksResponse.tasks.first?.preferredTime, date)
        XCTAssertNil(presenter.presentFetchTasksResponse.tasks.first?.image)
    }
    
    func testPrepareRouteToSheet() {
        // When
        interactor.prepareRouteToSheet()
        
        // Then
        XCTAssertTrue(presenter.presentPrepareRouteToSheetCalled)
    }
    
    func testPrepareRouteToOtherScene() {
        // When
        interactor.prepareRouteToOtherScene()
        
        // Then
        XCTAssertTrue(presenter.presentPrepareRouteToOtherSceneCalled)
    }
    
    // MARK: - Test Setup
    
    override func setUp() {
        super.setUp()
        service = TasksOverviewServiceDouble()
        presenter = TasksOverviewPresenterDouble()
        interactor = TasksOverviewInteractor(service: service, presenter: presenter)
    }
    
    // MARK: - Test Doubles
    
    // Either class, or struct with mutating functions
    class TasksOverviewPresenterDouble: TasksOverviewPresenting {
        var value: String?
        var presentUpdateThemeCalled = false
        var presentPrepareRouteToSheetCalled = false
        var presentPrepareRouteToOtherSceneCalled = false
        var presentFetchTasksResponse: TasksOverview.FetchTasks.Response!
        
        func presentUpdateTheme() {
            presentUpdateThemeCalled = true
        }
        
        func presentFetchTasks(with response: TasksOverview.FetchTasks.Response) {
            presentFetchTasksResponse = response
        }
        
        func presentPrepareRouteToSheet() {
            presentPrepareRouteToSheetCalled = true
        }
        
        func presentPrepareRouteToOtherScene() {
            presentPrepareRouteToOtherSceneCalled = true
        }
    }
    
    class TasksOverviewServiceDouble: TasksOverviewService {
        var tasksToReturn: [Task] = []
        
        func fetchTasks() -> [Task] {
            tasksToReturn
        }
    }
}
