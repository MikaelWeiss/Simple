//
//  CustomRecurrenceServiceTests.swift
//  Simple
//
//  Created by Mikael Weiss on 3/6/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import Simple

class CustomRecurrenceServiceTests: XCTestCase {
    private var service: CustomRecurrenceService!
    
    // MARK: - Setup
    
    override func setUp() {
        super.setUp()
        service = CustomRecurrence.Service()
    }
}

