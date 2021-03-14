//
//  EditTaskInteractorTests.swift
//  Simple
//
//  Created by Mikael Weiss on 2/13/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import XCTest
@testable import Simple

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
        service.taskInfoToReturn = EditTask.TaskInfo(
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
    
    func fetchTaskThrows() {
        // Given
        service.error = TestError.error
        
        // When
        
    }
    
//    func testDataPointUpdatePublisher() {
//        // Given
//        var subscription: AnyCancellable?
//        let expectation = self.expectation(description: #function)
//
//        subscription = service.dataPointUpdatePublisher
//            .delay(for: .milliseconds(1), scheduler: RunLoop.main)
//            .sink { _ in
//                expectation.fulfill()
//            }
//
//        // When
//        service.subject.send(.add(UUID()))
//
//        //  Then
//        waitForExpectations(timeout: 5, handler: nil)
//        XCTAssertTrue(self.service.refreshDataCalled)
//        XCTAssertTrue(self.service.fetchDataCalled)
//        XCTAssertTrue(self.presenter.presentFetchContentCalled)
//        subscription?.cancel()
//    }
    
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
        var error: TestError?
        
        var taskInfoToReturn: EditTask.TaskInfo!
        var canSaveReturn: Bool!
        
        var subject = RepositorySubject()
        var updatePublisher: RepositoryPublisher {
            subject.eraseToAnyPublisher()
        }
        
        func fetchTask() throws -> EditTask.TaskInfo {
            try testError(error)
            return taskInfoToReturn
        }
        
        func canSave() -> Bool {
            canSaveReturn
        }
        
        func validateTaskName(to name: String) throws {
            try testError(error)
            self.name = name
        }
        
        func validateTaskPreferredTime(to time: Date) throws {
            try testError(error)
            self.time = time
        }
        
        func validateTaskImage(to image: UIImage) throws {
            try testError(error)
            self.image = image
        }
        
        func save() throws {
            try testError(error)
            saveCalled = true
        }
        
        func deleteTask() throws {
            try testError(error)
            deleteTaskCalled = true
        }
        
        private func testError(_ error: TestError?) throws {
            if let error = error {
                throw error
            }
        }
    }
}
