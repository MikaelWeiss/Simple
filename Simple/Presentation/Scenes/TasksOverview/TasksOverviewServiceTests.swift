//
//  TasksOverviewServiceTests.swift
//  Simple
//
//  Created by Mikael Weiss on 2/12/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import Simple

class TasksOverviewServiceTests: XCTestCase {
    private var service: TasksOverviewService!
    
    // MARK: - Setup
    
    override func setUp() {
        super.setUp()
        service = TasksOverview.Service()
    }
}

