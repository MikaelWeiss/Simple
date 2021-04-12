//
//  XCTests+ExtensionsTests.swift
//  ElementsTests
//
//  Created by Mikael Weiss on 4/10/21.
//  Copyright © 2021 Elements Advisors, LLC. All rights reserved.
//

import XCTest

class XCTests_ExtensionsTests: XCTestCase {
    func testTrue() {
        XCTAssertNotNilAndTrue(true)
        XCTAssertNotNilAndFalse(false)
    }
}
