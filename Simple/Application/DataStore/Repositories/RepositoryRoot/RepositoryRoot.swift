//
//  RepositoryRoot.swift
//  Simple
//
//  Created by Mikael Weiss on 2/17/21.
//

import Foundation

typealias StorageReadable = TaskRepositoryReadable
typealias StorageWritable = TaskRepositoryWritable

class Repositories {
    static let storageRead = MainStorageProvider.shared.storageRead
    static let storageWrite = MainStorageProvider.shared.storageWrite
    
    var taskRepository = MainTaskRepository(
        storageRead: storageRead,
        storageWrite: storageWrite)
}
