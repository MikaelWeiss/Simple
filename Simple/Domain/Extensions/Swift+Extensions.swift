//
//  Swift+Extensions.swift
//  Simple
//
//  Created by Mikael Weiss on 3/5/21.
//

import Foundation

/// Try's what's in the call, throws the given error if the call throws
func this(error: Error, _ call: () throws -> Void) throws {
    do {
        try call()
    } catch {
        throw error
    }
}
