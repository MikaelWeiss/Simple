//
//  Task.swift
//  Simple
//
//  Created by Mikael Weiss on 2/15/21.
//

import SwiftUI

class Task: Identifiable {
    
    // MARK: - Stored Properties
    private(set) var id: UUID
    
    private(set) var name: String
    func set(name: String) throws {
        self.name = name
    }
    
    private(set) var preferredTime: Date
    func set(preferredTime: Date) throws {
        self.preferredTime = preferredTime
    }
    
    private(set) var recurrence: Recurrence
    func set(recurrence: Recurrence) throws {
        self.recurrence = recurrence
    }
    
    private(set) var image: UIImage?
    func set(image: UIImage?) throws {
        self.image = image
    }
    
    // MARK: - Initialization
    
    init(id: UUID = UUID(),
         name: String,
         preferredTime: Date = Date.today,
         recurrence: Recurrence,
         image: UIImage? = nil) {
        self.id = id
        self.name = name
        self.preferredTime = preferredTime
        self.recurrence = recurrence
        self.image = image
    }
    
    // MARK: - Reconstitution
    
    struct ReconstitutionInfo {
        let id: UUID
        let name: String
        let preferredTime: Date
        let frequency: Recurrence.ReconstitutionInfo
        let imageData: Data?
    }
    
    init(with info: ReconstitutionInfo) throws {
        self.id = info.id
        self.preferredTime = info.preferredTime
        self.recurrence = try Recurrence(with: info.recurrence)
        self.name = info.name
        self.image = UIImage(optionalData: info.imageData)
    }
}
