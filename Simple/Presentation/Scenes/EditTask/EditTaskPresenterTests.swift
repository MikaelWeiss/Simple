//
//  EditTaskPresenterTests.swift
//  Simple
//
//  Created by Mikael Weiss on 2/13/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import Simple

class EditTaskPresenterTests: XCTestCase {
    private var presenter: EditTaskPresenter!
    private var viewModel: EditTask.ViewModel!
    
    func testPresentUpdateTheme() {
        // When
        presenter.presentUpdateTheme()
        
        // Then
        XCTAssertEqual(viewModel.title, EditTask.Strings.sceneTitle)
        XCTAssertEqual(viewModel.textFieldTitle, EditTask.Strings.textFieldTitle)
    }
    
    func testPresentDidChangeValue() {
        // Given
        let response = EditTask.ValidateValue.Response(value: "Some value")
        
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
        presenter = EditTaskPresenter()
        viewModel = presenter.viewModel
    }
}



