//
//  TaskRepositoryTests.swift
//  SimpleTests
//
//  Created by Mikael Weiss on 2/15/21.
//

import XCTest
@testable import Simple
import Combine

class TaskRepositoryTests: XCTestCase {
    
    var repository: TaskRepository!
    var storageRead: TaskRepositoryReadableDouble!
    var storageWrite: TaskRepositoryWritableDouble!
    var toDomain: StorageToDomainTransformer!
    var toStorage: DomainToStorageTransformer!
    
    func testFetchAllTasks() throws {
        // Given
        let id = UUID()
        let time = Date.now
        storageRead.tasksToReturn = [makeStorageTask(id: id, name: "Do something cool", time: time)]
        
        // When
        let allTasks = try? repository.allTasks()
        
        // Then
        let task = allTasks?.first
        XCTAssertEqual(task?.id, id)
        XCTAssertEqual(task?.name, "Do something cool")
        XCTAssertEqual(task?.preferredTime, time)
        XCTAssertEqual(allTasks?.count, 1)
    }
    
    func testFetchTask() throws {
        // Given
        let id = UUID()
        storageRead.taskToReturn = makeStorageTask(id: id, name: "Do something else")
        
        // When
        let task = try? repository.task(withID: id)
        
        // Then
        XCTAssertEqual(task?.id, id)
        XCTAssertEqual(task?.name, "Do something else")
    }
    
    func testAddTask() throws {
        // Given
        let id = UUID()
        let task = makeTask(id: id)
        
        // When
        try repository.addTask(task)
        
        // Then
        let storageTask = storageWrite.addTaskTask
        XCTAssertEqual(storageTask?.id, id)
    }
    
    func testAddTaskPublishes() throws {
        // Given
        let expectation = self.expectation(description: "Publisher called")
        let id = UUID()
        let task = makeTask(id: id)
        let cancelable =
            repository.updatePublisher
            .delay(for: .milliseconds(1), scheduler: RunLoop.main)
            .sink { action in
                if case .add(let taskID) = action {
                    XCTAssertEqual(taskID, id)
                }
                expectation.fulfill()
            }
        
        // When
        try repository.addTask(task)
        
        // Then
        waitForExpectations(timeout: 1)
        cancelable.cancel()
    }
    
    
    func testUpdateTask() throws {
        // Given
        let id = UUID()
        storageWrite.updateTaskTask = makeStorageTask(id: id, name: "asdf")
        let task = makeTask(id: id, name: "Some new name")
        
        // When
        try repository.updateTask(task)
        
        // Then
        let storageTask = storageWrite.updateTaskTask
        XCTAssertEqual(storageTask?.id, id)
        XCTAssertEqual(storageTask?.name, "Some new name")
    }
    
    func testUpdateTaskPublishes() throws {
        // Given
        let expectation = self.expectation(description: "Publisher called")
        let id = UUID()
        let task = makeTask(id: id)
        let cancelable =
            repository.updatePublisher
            .delay(for: .milliseconds(1), scheduler: RunLoop.main)
            .sink { action in
                if case .update(let taskID) = action {
                    XCTAssertEqual(taskID, id)
                }
                expectation.fulfill()
            }
        
        // When
        try repository.updateTask(task)
        
        // Then
        waitForExpectations(timeout: 1)
        cancelable.cancel()
    }
    
    func testDeleteTask() throws {
        // Given
        let id = UUID()
        
        // When
        try repository.deleteTask(id)
        
        // Then
        XCTAssertEqual(storageWrite.deleteTaskID, id)
    }
    
    func testDeleteTaskPublishes() throws {
        // Given
        let id = UUID()
        let expectation = self.expectation(description: "Publisher called")
        let cancelable =
            repository.updatePublisher
            .delay(for: .milliseconds(1), scheduler: RunLoop.main)
            .sink { action in
                if case .update(let taskID) = action {
                    XCTAssertEqual(taskID, id)
                }
                expectation.fulfill()
            }
        
        // When
        try repository.deleteTask(id)
        
        // Then
        waitForExpectations(timeout: 1)
        cancelable.cancel()
    }
    
    private func makeStorageTask(id: UUID = UUID(), name: String = "some name", time: Date = Date()) -> Storage.Task {
        Storage.Task(id: id,
                     name: name,
                     preferredTime: time,
                     imageData: nil)
    }
    
    private func makeTask(id: UUID = UUID(), name: String = "") -> Task {
        Task(id: id, name: name, preferredTime: Date.now, image: nil)
    }
    
    // MARK: - Setup
    override func setUp() {
        super.setUp()
        toDomain = StorageToDomainFactory()
        toStorage = DomainToStorageFactory()
        storageRead = TaskRepositoryReadableDouble()
        storageWrite = TaskRepositoryWritableDouble()
        repository = MainTaskRepository(
            storageRead: storageRead,
            storageWrite: storageWrite,
            toDomainTransformer: toDomain,
            toStorageTransformer: toStorage)
    }
    
    // MARK: - Doubles
    class TaskRepositoryReadableDouble: TaskRepositoryReadable {
        var getTaskID: UUID?
        
        var taskToReturn: Storage.Task?
        var tasksToReturn = [Storage.Task]()
        
        func getTask(with id: UUID) throws -> Storage.Task? {
            taskToReturn
        }
        
        func getAllTasks() throws -> [Storage.Task] {
            tasksToReturn
        }
    }
    
    class TaskRepositoryWritableDouble: TaskRepositoryWritable {
        var addTaskTask: Storage.Task?
        var updateTaskTask: Storage.Task?
        var deleteTaskID: UUID?
        
        func addTask(_ storageTask: Storage.Task) throws {
            addTaskTask = storageTask
        }
        
        func updateTask(_ storageTask: Storage.Task) throws {
            updateTaskTask = storageTask
        }
        
        func deleteTask(with id: UUID) throws {
            deleteTaskID = id
        }
    }
}
