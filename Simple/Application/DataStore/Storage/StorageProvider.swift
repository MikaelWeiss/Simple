//
//  StorageProvider.swift
//  Simple
//
//  Created by Mikael Weiss on 2/15/21.
//

import Foundation

class StorageProvider {
    private let storage = CoreDataStorage()
    
    var storageRead: StorageReadable { storage }
    var storageWrite:  StorageWritable { storage }
}
