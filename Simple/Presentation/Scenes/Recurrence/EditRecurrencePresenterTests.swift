//
//  EditRecurrencePresenterTests.swift
//  Simple
//
//  Created by Mikael Weiss on 3/5/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import Simple

class EditRecurrencePresenterTests: XCTestCase {
    private var presenter: EditRecurrencePresenter!
    private var viewModel: EditRecurrence.ViewModel!
    
    func testPresentUpdateTheme() {
        // When
        presenter.presentSetup()
        
        // Then
        XCTAssertEqual(viewModel.title, EditRecurrence.Strings.sceneTitle)
        XCTAssertEqual(viewModel.textFieldTitle, EditRecurrence.Strings.textFieldTitle)
    }
    
    func testPresentDidChangeValue() {
        // Given
        let response = EditRecurrence.ValidateValue.Response(value: "Some value")
        
        // When
        presenter.presentDidChangeValue(with: response)
        
        // Then
        XCTAssertEqual(viewModel.textFieldValue, "Some value")
    }
    
    func testPresentPrepareRouteToSheet() {
        // When
        presenter.presentPrepareRouteToSheet()
        
        // Then
        XCTAssertTrue(viewModel.sheetShowing)
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
        presenter = EditRecurrencePresenter()
        viewModel = presenter.viewModel
    }
}



