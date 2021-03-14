//
//  EditTaskInteractorTests.swift
//  Simple
//
//  Created by Mikael Weiss on 2/13/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import Simple
import Combine

class EditTaskInteractorTests: XCTestCase {
    private var service: EditTaskServiceDouble!
    private var presenter: EditTaskPresenterDouble!
    private var interactor: EditTaskInteractor!
    
    func testUpdateTheme() {
        // When
        interactor.updateTheme()
        
        // Then
        XCTAssertTrue(presenter.presentUpdateThemeCalled)
    }
    
    func testFetchTask() {
        // Given
        let testDate = Date()
        service.taskInfoToReturn = buildTaskInfo(
            name: "Go Running",
            preferredTime: testDate,
            image: .add,
            taskExists: true)
        
        // When
        interactor.fetchTask()
        
        // Then
        let taskInfo = presenter.presentFetchTaskResponse?.task
        XCTAssertEqual(taskInfo?.name, "Go Running")
        XCTAssertEqual(taskInfo?.preferredTime, testDate)
        XCTAssertEqual(taskInfo?.image, .add)
        XCTAssertEqual(taskInfo?.taskExists, true)
    }
    
    func testFetchTaskThrows() {
        // Given
        service.error = EditTask.ServiceError.saveFailed
        service.taskInfoToReturn = buildTaskInfo()
        
        // When
        interactor.fetchTask()
        
        // Then
        let response = presenter.presentShowErrorResponse
        XCTAssertEqual(response?.error, .saveFailed)
    }
    
    func testDidChangeName() {
        // Given
        let request = EditTask.ValidateName.Request(value: "Work on Simple")
        
        // When
        interactor.didChangeName(with: request)
        
        // Then
        XCTAssertEqual(service.name, "Work on Simple")
        let response = presenter.presentDidChangeNameResponse
        XCTAssertEqual(response?.value, "Work on Simple")
        XCTAssertEqual(response?.valid, true)
    }
    
    func testDidChangeNameInvalid() {
        // Given
        service.error = .unknown
        let request = EditTask.ValidateName.Request(value: "Work on Simple")
        
        // When
        interactor.didChangeName(with: request)
        
        // Then
        let response = presenter.presentDidChangeNameResponse
        XCTAssertEqual(response?.value, "Work on Simple")
        XCTAssertEqual(response?.valid, false)
    }
    
    func testDidChangeDate() {
        // Given
        let testDate = Date()
        let request = EditTask.ValidateDate.Request(value: testDate)
        
        // When
        interactor.didChangeDate(with: request)
        
        // Then
        XCTAssertEqual(service.time, testDate)
        let response = presenter.presentDidChangeDateResponse
        XCTAssertEqual(response?.value, testDate)
    }
    
    func testDidChangeDateError() {
        // Given
        service.error = .validationError
        let request = EditTask.ValidateDate.Request(value: Date())
        
        // When
        interactor.didChangeDate(with: request)
        
        // Then
        XCTAssertNil(presenter.presentDidChangeDateResponse)
        let response = presenter.presentShowErrorResponse
        XCTAssertEqual(response?.error, .validationError)
    }
    
    func testDidTapRecurrenceSelection() {
        // When
        interactor.didTapRecurrenceSelection()
        
        // Then
        XCTAssertTrue(presenter.presentDidTapRecurrenceSelectionCalled)
    }
    
    func testDidTapDelete() {
        // When
        interactor.didTapDelete()
        
        // Then
        let response = presenter.presentDidTapDeleteResponse
        XCTAssertEqual(response?.didDelete, true)
    }
    
    func testDidTapDeleteThrows() {
        // Given
        service.error = .deleteFailed
        
        // When
        interactor.didTapDelete()
        
        // Then
        XCTAssertNil(presenter.presentDidTapDeleteResponse)
        let response = presenter.presentShowErrorResponse
        XCTAssertEqual(response?.error, .deleteFailed)
    }
    
    func testDidTapSave() {
        // When
        interactor.didTapSave()
        
        // Then
        let response = presenter.presentDidTapSaveResponse
        XCTAssertEqual(response?.didSave, true)
    }
    
    func testDidTapSaveThrows() {
        // Given
        service.error = .saveFailed
        
        // When
        interactor.didTapSave()
        
        // Then
        XCTAssertNil(presenter.presentDidTapSaveResponse)
        let response = presenter.presentShowErrorResponse
        XCTAssertEqual(response?.error, .saveFailed)
    }
    
    func testCheckCanSave() {
        // Given
        service.canSaveReturn = true
        
        // When
        interactor.checkCanSave()
        
        // Then
        let response = presenter.presentCanSaveResponse
        XCTAssertEqual(response?.canSave, true)
    }
    
    func testUpdatePublisher() {
        // Given
        service.taskInfoToReturn = buildTaskInfo()
        var subscription: AnyCancellable?
        let expectation = self.expectation(description: #function)

        subscription = service.updatePublisher
            .delay(for: .milliseconds(1), scheduler: RunLoop.main)
            .sink { _ in
                expectation.fulfill()
            }

        // When
        service.subject.send(.add(UUID()))

        //  Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(presenter.presentFetchTaskResponse)
        subscription?.cancel()
    }
    
    // MARK: - Helpers
    
    func buildTaskInfo(
        name: String = "",
        preferredTime: Date = Date(),
        image: UIImage = .add,
        taskExists: Bool = true) -> EditTask.TaskInfo {
        
        EditTask.TaskInfo(
            name: name,
            preferredTime: preferredTime,
            image: image,
            taskExists: taskExists
        )
    }
    
    // MARK: - Test Setup
    
    override func setUp() {
        super.setUp()
        service = EditTaskServiceDouble()
        presenter = EditTaskPresenterDouble()
        interactor = EditTaskInteractor(service: service, presenter: presenter)
    }
    
    // MARK: - Test Doubles
    
    // Either class, or struct with mutating functions
    class EditTaskPresenterDouble: EditTaskPresenting {
        var presentUpdateThemeCalled = false
        var presentFetchTaskResponse: EditTask.FetchTask.Response?
        var presentDidChangeNameResponse: EditTask.ValidateName.Response?
        var presentDidChangeDateResponse: EditTask.ValidateDate.Response?
        var presentDidTapRecurrenceSelectionCalled = false
        var presentCanSaveResponse: EditTask.CanSave.Response?
        var presentDidTapSaveResponse: EditTask.DidTapSave.Response?
        var presentDidTapDeleteResponse: EditTask.DidTapDelete.Response?
        var presentShowErrorResponse: EditTask.ShowError.Response?
        
        func presentUpdateTheme() {
            presentUpdateThemeCalled = true
        }
        
        func presentFetchTask(with response: EditTask.FetchTask.Response) {
            presentFetchTaskResponse = response
        }
        
        func presentDidChangeName(with response: EditTask.ValidateName.Response) {
            presentDidChangeNameResponse = response
        }
        
        func presentDidChangeDate(with response: EditTask.ValidateDate.Response) {
            presentDidChangeDateResponse = response
        }
        
        func presentDidTapRecurrenceSelection() {
            presentDidTapRecurrenceSelectionCalled = true
        }
        
        func presentCanSave(with response: EditTask.CanSave.Response) {
            presentCanSaveResponse = response
        }
        
        func presentDidTapSave(with response: EditTask.DidTapSave.Response) {
            presentDidTapSaveResponse = response
        }
        
        func presentDidTapDelete(with response: EditTask.DidTapDelete.Response) {
            presentDidTapDeleteResponse = response
        }
        
        func presentShowError(with response: EditTask.ShowError.Response) {
            presentShowErrorResponse = response
        }
    }
    
    class EditTaskServiceDouble: EditTaskService {
        var saveCalled = false
        var deleteTaskCalled = false
        var name: String?
        var time: Date?
        var image: UIImage?
        var error: EditTask.ServiceError?
        
        var taskInfoToReturn: EditTask.TaskInfo!
        var canSaveReturn: Bool!
        
        var subject = RepositorySubject()
        var updatePublisher: RepositoryPublisher {
            subject.eraseToAnyPublisher()
        }
        
        func fetchTask() throws -> EditTask.TaskInfo {
            try throwErrorIfNotNil(error)
            return taskInfoToReturn
        }
        
        func canSave() -> Bool {
            canSaveReturn
        }
        
        func validateTaskName(to name: String) throws {
            try throwErrorIfNotNil(error)
            self.name = name
        }
        
        func validateTaskPreferredTime(to time: Date) throws {
            try throwErrorIfNotNil(error)
            self.time = time
        }
        
        func validateTaskImage(to image: UIImage) throws {
            try throwErrorIfNotNil(error)
            self.image = image
        }
        
        func save() throws {
            try throwErrorIfNotNil(error)
            saveCalled = true
        }
        
        func deleteTask() throws {
            try throwErrorIfNotNil(error)
            deleteTaskCalled = true
        }
    }
}
