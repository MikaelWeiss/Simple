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
    
    private(set) var date: Date
    func set(date: Date) throws {
        self.date = date
    }
    
    private(set) var repetition: Repetition
    func set(repetition: Repetition) throws {
        self.repetition = repetition
    }
    
    private(set) var image: Image?
    func set(image: Image?) throws {
        self.image = image
    }
    
    // MARK: - Initialization
    
    init(id: UUID = UUID(), date: Date = Date(), repetition: Repetition, image: Image? = nil) {
        self.id = id
        self.date = date
        self.repetition = repetition
        self.image = image
    }
    
    // MARK: - Reconstitution
    
    struct ReconstitutionInfo {
        let id: UUID
        let name: String
        let date: Date
        let repetition: String
        let imageData: Data?
    }
    
    init(with info: ReconstitutionInfo) throws {
        self.id = info.id
        self.date = info.date
        self.name = info.name
        self.image = Image(data: info.imageData)
    }
}
