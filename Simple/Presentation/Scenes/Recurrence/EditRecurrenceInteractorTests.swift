//
//  EditRecurrenceInteractorTests.swift
//  Simple
//
//  Created by Mikael Weiss on 3/5/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import Simple

class EditRecurrenceInteractorTests: XCTestCase {
    private var service: EditRecurrenceServiceDouble!
    private var presenter: EditRecurrencePresenterDouble!
    private var interactor: EditRecurrenceInteractor!
    
    func testUpdateTheme() {
        // When
        interactor.setup()
        
        // Then
        XCTAssertTrue(presenter.presentUpdateThemeCalled)
    }
    
    func testDidChangeValue() {
        // Given
        let request = EditRecurrence.ValidateValue.Request(value: "Some new value")
        
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
    
    func tesetPrepareRouteToOtherScene() {
        // When
        interactor.prepareRouteToOtherScene()
        
        // Then
        XCTAssertTrue(presenter.presentPrepareRouteToOtherSceneCalled)
    }
    
    // MARK: - Test Setup
    
    override func setUp() {
        super.setUp()
        service = EditRecurrenceServiceDouble()
        presenter = EditRecurrencePresenterDouble()
        interactor = EditRecurrenceInteractor(service: service, presenter: presenter)
    }
    
    // MARK: - Test Doubles
    
    // Either class, or struct with mutating functions
    class EditRecurrencePresenterDouble: EditRecurrencePresenting {
        var value: String?
        var presentUpdateThemeCalled = false
        var presentPrepareRouteToSheetCalled = false
        var presentPrepareRouteToOtherSceneCalled = false
        
        func presentDidChangeValue(with response: EditRecurrence.ValidateValue.Response) {
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
    
    class EditRecurrenceServiceDouble: EditRecurrenceService {
    }
}
