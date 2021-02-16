//
//  StorageProvider.swift
//  Simple
//
//  Created by Mikael Weiss on 2/15/21.
//

import Foundation

protocol StorageProvider {
    var storageRead: StorageReadable { get }
    var storageWrite:  StorageWritable { get }
}

class MainStorageProvider: StorageProvider {
    static let shared = MainStorageProvider()
    
    private let storage = CoreDataStorage()
    
    var storageRead: StorageReadable { storage }
    var storageWrite:  StorageWritable { storage }
}
