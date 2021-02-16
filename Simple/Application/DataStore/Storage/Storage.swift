//
//  Storage.swift
//  Simple
//
//  Created by Mikael Weiss on 2/15/21.
//

import Foundation

enum Storage {
    struct Task: Codable {
        let id: UUID?
        let name: String?
        let preferredTime: Date?
        let frequency: String?
        let imageData: Data?
    }
}
