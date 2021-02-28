//
//  EditTaskViewTests.swift
//  Simple
//
//  Created by Mikael Weiss on 2/13/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import Simple

class EditTaskViewTests: XCTestCase {
    private var interactor: EditTaskInteractorDouble!
    private var viewModel: EditTask.ViewModel!
    private var view: EditTaskView!
    
    func testDidChangeValue() {
        // When
        view.didChangeValue(to: "Some Value")
        
        // Then
        XCTAssertEqual(interactor.value, "Some Value")
    }
    
    func testPrepareRouteToSheet() {
        // When
        view.prepareRouteToSheet()
        
        // Then
        XCTAssertTrue(interactor.prepareRouteToSheetCalled)
    }
    
    func testPrepareRouteToOtherScene() {
        // When
        view.prepareRouteToOtherScene()
        
        // Then
        XCTAssertTrue(interactor.prepareRouteToOtherSceneCalled)
    }
    
    // MARK: - Test Setup
    
    override func setUp() {
        super.setUp()
        interactor = EditTaskInteractorDouble()
        viewModel = EditTask.ViewModel()
        view = EditTaskView(interactor: interactor, viewModel: viewModel)
    }
    
    // MARK: - Test Doubles
    
    class EditTaskInteractorDouble: EditTaskRequesting {
        var value: String?
        var updateThemeCalled = false
        var prepareRouteToSheetCalled = false
        var prepareRouteToOtherSceneCalled = false
        
        func didChangeValue(with request: EditTask.ValidateValue.Request) {
            value = request.value
        }
        
        func updateTheme() {
            updateThemeCalled = true
        }
        
        func prepareRouteToSheet() {
            prepareRouteToSheetCalled = true
        }
        
        func prepareRouteToOtherScene() {
            prepareRouteToOtherSceneCalled = true
        }
    }
}
