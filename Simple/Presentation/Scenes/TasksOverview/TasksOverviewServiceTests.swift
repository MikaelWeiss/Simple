////
////  TasksOverviewServiceTests.swift
////  Simple
////
////  Created by Mikael Weiss on 2/12/21.
////  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
////
//
//import XCTest
//@testable import Simple
//
//class TasksOverviewServiceTests: XCTestCase {
//    private var service: TasksOverviewService!
//    private var fetchingDouble: TaskOverviewTaskFetchingDouble!
//    
//    // MARK: - Setup
//    
//    override func setUp() {
//        super.setUp()
//        fetchingDouble = TaskOverviewTaskFetchingDouble()
//        service = TasksOverview.Service(taskRepository: fetchingDouble)
//    }
//    
//    // MARK: - Doubles
//    
//    class TaskOverviewTaskFetchingDouble: TaskOverviewTaskFetching {
//        var tasksToReturn: [Task]!
//        
//        var subject = RepositorySubject()
//        var updatePublisher: RepositoryPublisher {
//            subject.eraseToAnyPublisher()
//        }
//        
//        func allTasks() throws -> [Task] {
//            tasksToReturn
//        }
//    }
//}
//
