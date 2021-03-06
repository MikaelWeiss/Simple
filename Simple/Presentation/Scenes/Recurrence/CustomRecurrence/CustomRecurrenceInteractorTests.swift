//
//  CustomRecurrenceInteractorTests.swift
//  Simple
//
//  Created by Mikael Weiss on 3/6/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import Simple

class CustomRecurrenceInteractorTests: XCTestCase {
    private var service: CustomRecurrenceServiceDouble!
    private var presenter: CustomRecurrencePresenterDouble!
    private var interactor: CustomRecurrenceInteractor!
    
    func testUpdateTheme() {
        // When
        interactor.updateTheme()
        
        // Then
        XCTAssertTrue(presenter.presentUpdateThemeCalled)
    }
    
    func testDidChangeValue() {
        // Given
        let request = CustomRecurrence.ValidateValue.Request(value: "Some new value")
        
        // When
        interactor.didChangeValue(with: request)
        
        // Then
        XCTAssertEqual(presenter.value, "Some new value")
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
        service = CustomRecurrenceServiceDouble()
        presenter = CustomRecurrencePresenterDouble()
        interactor = CustomRecurrenceInteractor(service: service, presenter: presenter)
    }
    
    // MARK: - Test Doubles
    
    // Either class, or struct with mutating functions
    class CustomRecurrencePresenterDouble: CustomRecurrencePresenting {
        var value: String?
        var presentUpdateThemeCalled = false
        var presentPrepareRouteToSheetCalled = false
        var presentPrepareRouteToOtherSceneCalled = false
        
        func presentDidChangeValue(with response: CustomRecurrence.ValidateValue.Response) {
            value = response.value
        }
        
        func presentUpdateTheme() {
            presentUpdateThemeCalled = true
        }
        
        func presentPrepareRouteToSheet() {
            presentPrepareRouteToSheetCalled = true
        }
        
        func presentPrepareRouteToOtherScene() {
            presentPrepareRouteToOtherSceneCalled = true
        }
    }
    
    class CustomRecurrenceServiceDouble: CustomRecurrenceService {
    }
}
