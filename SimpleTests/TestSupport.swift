//
//  TestSupport.swift
//  SimpleTests
//
//  Created by Mikael Weiss on 3/13/21.
//

import Foundation

enum TestError: Error {
    case error
}

func throwErrorIfNotNil(_ error: Error?) throws {
    if let error = error {
        throw error
    }
}
