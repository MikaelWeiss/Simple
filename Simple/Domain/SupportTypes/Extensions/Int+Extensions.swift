//
//  Int+Extensions.swift
//  Simple
//
//  Created by Mikael Weiss on 3/4/21.
//

import Foundation

enum RangeError: Error {
    case outsideOfRange
}

extension Int {
    func residesInRange(min: Int, max: Int, default: Int) -> Int {
        if self > min && self < max {
            return self
        } else {
            return `default`
        }
    }
    
    func residesInRange(min: Int, max: Int) throws -> Int {
        if self > min && self < max {
            return self
        } else {
            throw RangeError.outsideOfRange
        }
    }
}
