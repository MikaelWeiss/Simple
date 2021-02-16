//
//  StorageWritable.swift
//  Simple
//
//  Created by Mikael Weiss on 2/15/21.
//

import Foundation

protocol StorageWritable {
    
    // MARK: - Tasks
    func addTask(_ storageTask: Storage.Task) throws
    func updateTask(_ storageTask: Storage.Task) throws
    func deleteTask(with id: UUID) throws
}
