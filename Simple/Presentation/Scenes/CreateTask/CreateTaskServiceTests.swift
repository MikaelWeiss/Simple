//
//  CreateTaskServiceTests.swift
//  Simple
//
//  Created by Mikael Weiss on 2/13/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import Simple

class CreateTaskServiceTests: XCTestCase {
    private var service: CreateTaskService!
    
    // MARK: - Setup
    
    override func setUp() {
        super.setUp()
        service = CreateTask.Service()
    }
}

