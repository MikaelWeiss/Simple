//
//  CreateTaskPresenterTests.swift
//  Simple
//
//  Created by Mikael Weiss on 2/13/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import Simple

class CreateTaskPresenterTests: XCTestCase {
    private var presenter: CreateTaskPresenter!
    private var viewModel: CreateTask.ViewModel!
    
    func testPresentUpdateTheme() {
        // When
        presenter.presentUpdateTheme()
        
        // Then
        XCTAssertEqual(viewModel.title, CreateTask.Strings.sceneTitle)
        XCTAssertEqual(viewModel.textFieldTitle, CreateTask.Strings.textFieldTitle)
    }
    
    func testPresentDidChangeValue() {
        // Given
        let response = CreateTask.ValidateValue.Response(value: "Some value")
        
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
        presenter = CreateTaskPresenter()
        viewModel = presenter.viewModel
    }
}



