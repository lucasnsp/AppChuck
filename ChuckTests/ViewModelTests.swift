//
//  ViewModelTests.swift
//  ChuckTests
//
//  Created by Lucas Neves dos santos pompeu on 26/12/23.
//

import XCTest
@testable import Chuck

final class ViewModelTests: XCTestCase {

    var viewModel: HomeViewModel!
    var mockService: MockHomeService!

    override func setUpWithError() throws {
        mockService = MockHomeService()
        viewModel = HomeViewModel(service: mockService)
    }

    override func tearDownWithError() throws {
        mockService = nil
        viewModel = nil
    }

    func testFetchRequestSuccess() throws {
        var list: [String] = ["category1", "category2"]
        mockService.result = .success(list)

        viewModel.fetchRequest()

        XCTAssertEqual(viewModel.numberOfRowsInSection, list.count)
        XCTAssertEqual(viewModel.loadCurrentCategory(indexPath: IndexPath(row: 0, section: 0)), list[0])
    }
}

class MockHomeService: HomeServiceDelegate {
    var result: Result<[String], Error> = .success([])
    func getHome(completion: @escaping (Result<[String], Error>) -> Void) {
        completion(result)
    }
}
