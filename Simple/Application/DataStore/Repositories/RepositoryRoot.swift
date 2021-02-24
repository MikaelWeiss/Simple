//
//  RepositoryRoot.swift
//  Simple
//
//  Created by Mikael Weiss on 2/17/21.
//

import Foundation

typealias StorageReadable = TaskRepositoryReadable
typealias StorageWritable = TaskRepositoryWritable

class RepositoryRoot {
    static private let storage = CoreDataStorage()
    static private let storageRead = storage
    static private let storageWrite = storage
    
    static var shared = RepositoryRoot()
    
    var taskRepository = MainTaskRepository(
        storageRead: storageRead,
        storageWrite: storageWrite)
}
