//
//  CustomRecurrencePresenterTests.swift
//  Simple
//
//  Created by Mikael Weiss on 3/6/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import Simple

class CustomRecurrencePresenterTests: XCTestCase {
    private var presenter: CustomRecurrencePresenter!
    private var viewModel: CustomRecurrence.ViewModel!
    
    func testPresentUpdateTheme() {
        // When
        presenter.presentUpdateTheme()
        
        // Then
        XCTAssertEqual(viewModel.title, CustomRecurrence.Strings.sceneTitle)
        XCTAssertEqual(viewModel.textFieldTitle, CustomRecurrence.Strings.textFieldTitle)
    }
    
    func testPresentDidChangeValue() {
        // Given
        let response = CustomRecurrence.ValidateValue.Response(value: "Some value")
        
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
        presenter = CustomRecurrencePresenter()
        viewModel = presenter.viewModel
    }
}



