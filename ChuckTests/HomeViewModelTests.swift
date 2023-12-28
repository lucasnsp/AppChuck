//
//  ViewModelTests.swift
//  ChuckTests
//
//  Created by Lucas Neves dos santos pompeu on 26/12/23.
//

import XCTest
@testable import Chuck

final class HomeViewModelTests: XCTestCase {

    var viewModel: HomeViewModel!
    var mockService: MockHomeService!
    var mockDelegate: MockHomeViewModelDelegate!

    override func setUpWithError() throws {
        mockService = MockHomeService()
        viewModel = HomeViewModel(service: mockService)
        mockDelegate = MockHomeViewModelDelegate()
        viewModel.delegate(delegate: mockDelegate)
    }

    override func tearDownWithError() throws {
        mockService = nil
        viewModel = nil
        mockDelegate = nil
    }

    func testFetchRequestSuccess() throws {
        let list: [String] = ["category1", "category2"]
        mockService.result = .success(list)

        viewModel.fetchRequest()

        XCTAssertEqual(viewModel.numberOfRowsInSection, list.count)
        XCTAssertEqual(viewModel.loadCurrentCategory(indexPath: IndexPath(row: 0, section: 0)), list[0])
        XCTAssertTrue(mockDelegate.successCalled)
    }

    func testFetchRequestFailure() throws {
        mockService.result = .failure(NSError(domain: "com.test.error", code: 0))
        viewModel.fetchRequest()

        XCTAssertEqual(viewModel.numberOfRowsInSection, 0)
        XCTAssertTrue(mockDelegate.errorCalled)
    }
}

class MockHomeViewModelDelegate: HomeViewModelProtocol {
    var successCalled = false
    var errorCalled = false

    func success() {
        successCalled = true
    }
    
    func error(message: String) {
        errorCalled = true
    }
}

class MockHomeService: HomeServiceDelegate {
    var result: Result<[String], Error> = .success([])
    func getHome(completion: @escaping (Result<[String], Error>) -> Void) {
        completion(result)
    }
}
