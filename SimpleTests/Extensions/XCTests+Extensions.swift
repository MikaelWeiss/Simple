//
//  XCTests+Extensions.swift
//  ElementsTests
//
//  Created by Mikael Weiss on 4/10/21.
//  Copyright © 2021 Elements Advisors, LLC. All rights reserved.
//

import XCTest

extension XCTest {
    func XCTAssertNotNilAndTrue(
        _ expression: @autoclosure () throws -> Bool?,
        _ message: @autoclosure () -> String = "",
        file: StaticString = #filePath,
        line: UInt = #line) {
        
        if let value = try? expression() {
            XCTAssertTrue(value, message(), file: file, line: line)
            return
        }
        XCTAssertNotNil(try? expression(), file: file, line: line)
    }
    
    func XCTAssertNotNilAndFalse(
        _ expression: @autoclosure () throws -> Bool?,
        _ message: @autoclosure () -> String = "",
        file: StaticString = #filePath,
        line: UInt = #line) {
        
        if let value = try? expression() {
            XCTAssertFalse(value, message(), file: file, line: line)
            return
        }
        XCTAssertNotNil(try? expression(), file: file, line: line)
    }
}
