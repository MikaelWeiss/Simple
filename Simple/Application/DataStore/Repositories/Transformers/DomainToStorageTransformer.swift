//
//  DomainToStorageTransformer.swift
//  Simple
//
//  Created by Mikael Weiss on 2/15/21.
//

import Foundation

protocol DomainToStorageTransformer {
    func task(from domainTask: Task) -> Storage.Task
}

class DomainToStorageFactory: DomainToStorageTransformer {
    func task(from domainTask: Task) -> Storage.Task {
        Storage.Task(
            id: domainTask.id,
            name: domainTask.name,
            preferredTime: domainTask.preferredTime,
            frequency: domainTask.frequency.stringValue,
            imageData: domainTask.image?.pngData())
    }
}
