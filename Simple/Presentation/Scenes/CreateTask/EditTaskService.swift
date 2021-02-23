//
//  EditTaskService.swift
//  Simple
//
//  Created by Mikael Weiss on 2/13/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol EditTaskService {
    func fetchFrequencies() -> [Frequency]
    func fetchTask() -> EditTask.TaskInfo
    func canSave() -> Bool
    func validateTaskName(to name: String) throws
    func validateTaskPreferredTime(to time: Date) throws
    func validateTaskFrequency(to frequency: Frequency) throws
    func validateTaskImage(to image: UIImage) throws
    func save() throws
    func syncTask() throws
}

protocol EditTaskTaskUpdating {
    
}

extension EditTask {
    
    enum ServiceError: Error {
        case syncFailed
        case missingRequiredFields
        case validationError
        case saveFailed
    }
    
    struct TaskInfo {
        var name: String?
        var preferredTime: Date?
        var frequency: Frequency?
        var image: UIImage?
    }
    
    class Service: EditTaskService {
        
        private var taskRepository: TaskRepository
        private var task: Task?
        private var taskInfo: TaskInfo
        
        var updatePublisher: RepositoryPublisher {
            taskRepository.updatePublisher
        }
        
        init(task: Task?, taskRepository: TaskRepository) {
            self.task = task
            self.taskRepository = taskRepository
            taskInfo = TaskInfo(
                name: task?.name,
                preferredTime: task?.preferredTime,
                frequency: task?.frequency,
                image: task?.image)
        }
        
        func fetchFrequencies() -> [Frequency] {
            Frequency.allCases
        }
        
        func fetchTask() -> TaskInfo {
            taskInfo
        }
        
        func canSave() -> Bool {
            guard let name = taskInfo.name,
                  name.isEmpty,
                  taskInfo.frequency != nil,
                  taskInfo.preferredTime != nil
            else { return false }
            return true
        }
        
        func validateTaskName(to name: String) throws {
            if name.isEmpty {
                throw ServiceError.validationError
            }
            taskInfo.name = name
        }
        
        func validateTaskPreferredTime(to time: Date) throws {
            taskInfo.preferredTime = time
        }
        
        func validateTaskFrequency(to frequency: Frequency) throws {
            taskInfo.frequency = frequency
        }
        
        func validateTaskImage(to image: UIImage) throws {
            taskInfo.image = image
        }
        
        func save() throws {
            guard canSave() else { throw ServiceError.missingRequiredFields }
            let taskToSave: Task
            
            if let task = self.task {
                taskToSave = task
            } else {
                taskToSave = try makeTask(with: taskInfo)
            }
            
            do {
                try taskRepository.addTask(taskToSave)
            } catch {
                throw ServiceError.saveFailed
            }
        }
        
        private func makeTask(with info: TaskInfo) throws -> Task {
            guard let name = info.name,
                  let preferredTime = info.preferredTime,
                  let frequency = info.frequency
            else { throw ServiceError.saveFailed }
            return Task(name: name,
                        preferredTime: preferredTime,
                        frequency: frequency,
                        image: info.image)
        }
        
        func syncTask() throws {
            guard let id = task?.id else { throw ServiceError.syncFailed }
            do {
                self.task = try taskRepository.task(withID: id)
            } catch {
                throw ServiceError.syncFailed
            }
        }
    }
}
