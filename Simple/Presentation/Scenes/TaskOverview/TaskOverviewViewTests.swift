//
//  TaskOverviewViewTests.swift
//  Simple
//
//  Created by Mikael Weiss on 2/12/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import Simple

class TaskOverviewViewTests: XCTestCase {
    private var interactor: TaskOverviewInteractorDouble!
    private var viewModel: TaskOverview.ViewModel!
    private var view: TaskOverviewView!
    
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
        interactor = TaskOverviewInteractorDouble()
        viewModel = TaskOverview.ViewModel()
        view = TaskOverviewView(interactor: interactor, viewModel: viewModel)
    }
    
    // MARK: - Test Doubles
    
    class TaskOverviewInteractorDouble: TaskOverviewRequesting {
        var value: String?
        var updateThemeCalled = false
        var prepareRouteToSheetCalled = false
        var prepareRouteToOtherSceneCalled = false
        
        func didChangeValue(with request: TaskOverview.ValidateValue.Request) {
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
