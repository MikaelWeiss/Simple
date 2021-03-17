////
////  EditTaskPresenterTests.swift
////  Simple
////
////  Created by Mikael Weiss on 2/13/21.
////  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
////
//
//import XCTest
//@testable import Simple
//
//class EditTaskPresenterTests: XCTestCase {
//    private var presenter: EditTaskPresenter!
//    private var viewModel: EditTask.ViewModel!
//    
//    func testPresentUpdateTheme() {
//        // When
//        presenter.presentUpdateTheme()
//        
//        // Then
//        XCTAssertEqual(viewModel.nameTitle, "Name")
//        XCTAssertEqual(viewModel.preferredTimeTitle, "Date:")
//        XCTAssertEqual(viewModel.recurrenceTitle, "Repetition:")
//    }
//    
//    func testPresentFetchTask() {
//        // Given
//        let testDate = Date()
//        let task = EditTask.TaskInfo(
//            name: "Wake up",
//            preferredTime: testDate,
//            image: UIImage.add,
//            taskExists: true)
//        let response = EditTask.FetchTask.Response(task: task)
//        
//        // When
//        presenter.presentFetchTask(with: response)
//        
//        // Then
//        XCTAssertEqual(viewModel.nameInfo.value, "Wake up")
//        XCTAssertEqual(viewModel.nameInfo.state, .normal)
//        XCTAssertEqual(viewModel.preferredTime, testDate)
//        XCTAssertEqual(viewModel.title, "Edit Task")
//    }
//    
//    // MARK: - Test Setup
//    
//    override func setUp() {
//        super.setUp()
//        presenter = EditTaskPresenter()
//        viewModel = presenter.viewModel
//    }
//}
