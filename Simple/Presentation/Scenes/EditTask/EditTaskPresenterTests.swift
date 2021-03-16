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
        // Given
        presenter.presentUpdateTheme()
        
        // When
        <#When#>
        
        // Then
        <#Then#>
    }
    
    // MARK: - Test Setup
    
    override func setUp() {
        super.setUp()
        presenter = EditTaskPresenter()
        viewModel = presenter.viewModel
    }
}



