//
//  StorageToDomainTransformer.swift
//  Simple
//
//  Created by Mikael Weiss on 2/15/21.
//

import SwiftUI

enum ReconstitutionError: Error {
    case missingRequiredFields
    case invalidOption(String)
}

protocol StorageToDomainTransformer {
    func task(from storageTask: Storage.Task) throws -> Task
}

class StorageToDomainFactory: StorageToDomainTransformer {
    func task(from storageTask: Storage.Task) throws -> Task {
        guard let id = storageTask.id,
              let name = storageTask.name,
              let preferredTime = storageTask.preferredTime
        else { throw ReconstitutionError.missingRequiredFields }
        
        let taskInfo = Task.ReconstitutionInfo(
            id: id,
            name: name,
            preferredTime: preferredTime,
            imageData: storageTask.imageData)
        
        return try Task(with: taskInfo)
    }
}
