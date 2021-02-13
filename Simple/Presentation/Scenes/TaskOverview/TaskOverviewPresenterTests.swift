//
//  TaskOverviewPresenterTests.swift
//  Simple
//
//  Created by Mikael Weiss on 2/12/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import Simple

class TaskOverviewPresenterTests: XCTestCase {
    private var presenter: TaskOverviewPresenter!
    private var viewModel: TaskOverview.ViewModel!
    
    func testPresentUpdateTheme() {
        // When
        presenter.presentUpdateTheme()
        
        // Then
        XCTAssertEqual(viewModel.title, TaskOverview.Strings.sceneTitle)
        XCTAssertEqual(viewModel.textFieldTitle, TaskOverview.Strings.textFieldTitle)
    }
    
    func testPresentDidChangeValue() {
        // Given
        let response = TaskOverview.ValidateValue.Response(value: "Some value")
        
        // When
        presenter.presentDidChangeValue(with: response)
        
        // Then
        XCTAssertEqual(viewModel.textFieldValue, "Some value")
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
        presenter = TaskOverviewPresenter()
        viewModel = presenter.viewModel
    }
}



