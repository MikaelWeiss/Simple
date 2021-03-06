//
//  Interval.swift
//  Simple
//
//  Created by Mikael Weiss on 3/5/21.
//

import Foundation

struct Interval {
    private(set) var interval: Int
    mutating func set(value: Int) throws {
        try this(error: DomainError.setFailed) {
            self.interval = try value.residesInRange(min: 0, max: 24)
        }
    }
    
    // MARK: - Init
    
    init(interval: Int = 1) throws {
        self.interval = try interval.residesInRange(min: 0, max: 24)
    }
    
    // MARK: - Reconstitution
    
    struct ReconstitutionInfo {
        let interval: Int
    }
    
    init(with info: ReconstitutionInfo) throws {
        do {
            self.interval = try info.interval.residesInRange(min: 0, max: 24)
        } catch {
            throw ReconstitutionError.invalidOption("Interval out of range: \(info.interval)")
        }
    }
}
