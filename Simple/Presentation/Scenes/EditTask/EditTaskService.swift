//
//  EditTaskService.swift
//  Simple
//
//  Created by Mikael Weiss on 2/13/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol EditTaskService {
    func fetchTask() throws -> EditTask.TaskInfo
    func canSave() -> Bool
    func validateTaskName(to name: String) throws
    func validateTaskPreferredTime(to time: Date) throws
//    func validateTaskFrequency(to frequency: Frequency) throws
    func validateTaskImage(to image: UIImage) throws
    func save() throws
    func deleteTask() throws
    func syncTask() throws
    var updatePublisher: RepositoryPublisher { get }
}

protocol EditTaskTaskUpdating {
    func task(withID: UUID) throws -> Task?
    
    func addTask(_ task: Task) throws
    func updateTask(_ task: Task) throws
    func deleteTask(_ id: UUID) throws
    
    var updatePublisher: RepositoryPublisher { get }
}
extension MainTaskRepository: EditTaskTaskUpdating { }

extension EditTask {
    
    enum ServiceError: Error {
        case syncFailed
        case missingRequiredFields
        case validationError
        case saveFailed, updateFailed, deleteFailed
        case fetchFailed
        case unknown
    }
    
    struct TaskInfo {
        var name: String?
        var preferredTime: Date?
//        var frequency: Frequency?
        var image: UIImage?
    }
    
    class Service: EditTaskService {
        
        typealias ServiceError = EditTask.ServiceError
        typealias TaskInfo = EditTask.TaskInfo
        
        private var taskRepository: EditTaskTaskUpdating
        private var taskID: UUID?
        private var task: Task?
        private var taskInfo: TaskInfo
        
        var updatePublisher: RepositoryPublisher {
            taskRepository.updatePublisher
        }
        
        init(taskID: UUID?, taskRepository: EditTaskTaskUpdating) {
            self.taskRepository = taskRepository
            self.taskID = taskID
            self.task = nil
            
            taskInfo = TaskInfo(
                name: nil,
                preferredTime: Date.now,
//                frequency: .daily,
                image: nil)
        }
        
        func fetchTask() throws -> TaskInfo {
            if let taskID = taskID {
                do {
                    task = try taskRepository.task(withID: taskID)
                } catch {
                    throw ServiceError.fetchFailed
                }
            }
            taskInfo = TaskInfo(
                name: task?.name,
                preferredTime: task?.preferredTime ?? Date.now,
//                frequency: task?.frequency ?? .daily,
                image: task?.image)
            
            return taskInfo
        }
        
        func canSave() -> Bool {
            guard let name = taskInfo.name,
                  !name.isEmpty,
//                  taskInfo.frequency != nil,
                  taskInfo.preferredTime != nil
            else { return false }
            return true
        }
        
        func validateTaskName(to name: String) throws {
            if name.isEmpty {
                taskInfo.name = nil
                throw ServiceError.validationError
            }
            taskInfo.name = name
        }
        
        func validateTaskPreferredTime(to time: Date) throws {
            taskInfo.preferredTime = time
        }
        
//        func validateTaskFrequency(to frequency: Frequency) throws {
//            taskInfo.frequency = frequency
//        }
        
        func validateTaskImage(to image: UIImage) throws {
            taskInfo.image = image
        }
        
        func save() throws {
            guard canSave() else { throw ServiceError.missingRequiredFields }
            
            do {
                if let task = self.task {
                    try updateTask(task, withInfo: taskInfo)
                    try taskRepository.updateTask(task)
                } else {
                    let task = try makeTask(with: taskInfo)
                    try taskRepository.addTask(task)
                    self.task = task
                }
            } catch {
                if error is ServiceError {
                    throw error
                }
                throw ServiceError.saveFailed
            }
        }
        
        private func makeTask(with info: TaskInfo) throws -> Task {
            guard let name = info.name,
                  let preferredTime = info.preferredTime
//                  let frequency = info.frequency
            else { throw ServiceError.saveFailed }
            return Task(name: name,
                        preferredTime: preferredTime,
//                        frequency: frequency,
                        image: info.image)
        }
        
        private func updateTask(_ task: Task, withInfo info: TaskInfo) throws {
            guard let name = info.name,
                  let preferredTime = info.preferredTime
//                  let frequency = info.frequency
            else { throw ServiceError.saveFailed }
            
            do {
                try task.set(name: name)
                try task.set(preferredTime: preferredTime)
//                try task.set(frequency: frequency)
                try task.set(image: info.image)
            } catch {
                throw ServiceError.updateFailed
            }
        }
        
        func deleteTask() throws {
            guard let id = task?.id else { throw ServiceError.syncFailed }
            do {
                try taskRepository.deleteTask(id)
            } catch {
                throw ServiceError.deleteFailed
            }
        }
        
        func syncTask() throws {
            guard let id = task?.id else { throw ServiceError.syncFailed }
            do {
                self.task = try taskRepository.task(withID: id)
                // Add code to update the ui?
            } catch {
                throw ServiceError.syncFailed
            }
        }
    }
}
