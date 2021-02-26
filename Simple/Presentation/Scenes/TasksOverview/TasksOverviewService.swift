//
//  TasksOverviewService.swift
//  Simple
//
//  Created by Mikael Weiss on 2/12/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI

protocol TaskOverviewTaskFetching {
    func allTasks() throws -> [Task]
    var updatePublisher: RepositoryPublisher { get }
}
extension MainTaskRepository: TaskOverviewTaskFetching { }

protocol TasksOverviewService {
    func fetchTasks() throws -> [Task]
    func prepareRouteToEditTask(with id: UUID)
    var updatePublisher: RepositoryPublisher { get }
}

extension TasksOverview {
    enum ServiceError: Error {
        case fetchFailed
        case unknownError
    }
    
    class Service: TasksOverviewService {
        private var taskRepository: TaskOverviewTaskFetching
        
        var updatePublisher: RepositoryPublisher {
            taskRepository.updatePublisher
        }
        
        init(taskRepository: TaskOverviewTaskFetching) {
            self.taskRepository = taskRepository
        }
        
        func fetchTasks() throws -> [Task] {
            do {
                let tasks = try taskRepository.allTasks()
                return tasks
            } catch {
                throw ServiceError.fetchFailed
            }
        }
        
        func prepareRouteToEditTask(with id: UUID) {
            EditTask.input = .init(taskID: id)
        }
    }
}
