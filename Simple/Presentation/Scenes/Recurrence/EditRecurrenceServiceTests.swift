//
//  EditRecurrenceServiceTests.swift
//  Simple
//
//  Created by Mikael Weiss on 3/5/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import Simple

class EditRecurrenceServiceTests: XCTestCase {
    private var service: EditRecurrenceService!
    
    // MARK: - Setup
    
    override func setUp() {
        super.setUp()
        service = EditRecurrence.Service()
    }
}

