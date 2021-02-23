//
//  TasksOverviewPresenterTests.swift
//  Simple
//
//  Created by Mikael Weiss on 2/12/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import Simple

class TasksOverviewPresenterTests: XCTestCase {
    private var presenter: TasksOverviewPresenter!
    private var viewModel: TasksOverview.ViewModel!
    
    func testPresentUpdateTheme() {
        // When
        presenter.presentUpdateTheme()
        
        // Then
        XCTAssertEqual(viewModel.title, "Overview")
    }
    
    func testPresentFetchTasks() {
        // Given
        let firstDate = Date()
        let secondDate = Date().advanced(by: 50)
        let response = TasksOverview.FetchTasks.Response(
            tasks: [.init(name: "one task", preferredTime: secondDate, frequency: .daily, image: nil),
                    .init(name: "another task", preferredTime: firstDate, frequency: .daily, image: nil)])
        
        // When
        presenter.presentFetchTasks(with: response)
        
        // Then
        XCTAssertEqual(viewModel.allTasks[0].name, "another task")
        XCTAssertEqual(viewModel.allTasks[1].name, "one task")
    }
    
    func testPresentPrepareRouteToSheet() {
        // When
        presenter.presentPrepareRouteToSheet()
        
        // Then
        XCTAssertTrue(viewModel.isShowingSheet)
    }
    
    func testPresentPrepareRouteToOtherScene() {
        // When
        presenter.presentPrepareRouteToOtherScene()
        
        // Then
        XCTAssertTrue(viewModel.isShowingOtherScene)
    }
    
    // MARK: - Test Setup
    
    override func setUp() {
        super.setUp()
        presenter = TasksOverviewPresenter()
        viewModel = presenter.viewModel
    }
}



