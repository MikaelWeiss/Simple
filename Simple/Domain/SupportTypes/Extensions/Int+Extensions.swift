//
//  Int+Extensions.swift
//  Simple
//
//  Created by Mikael Weiss on 3/4/21.
//

import Foundation

extension Int {
    func residesInRange(min: Int, max: Int, default: Int) -> Int {
        if self > min && self < max {
            return self
        } else {
            return `default`
        }
    }
}
