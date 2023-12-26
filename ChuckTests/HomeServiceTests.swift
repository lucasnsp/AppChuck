//
//  HomeServiceTests.swift
//  ChuckTests
//
//  Created by Lucas Neves dos santos pompeu on 13/12/23.
//

import XCTest
import OHHTTPStubs
@testable import Chuck

final class HomeServiceTests: XCTestCase {

    var homeService: HomeService!

    override func setUpWithError() throws {
        homeService = HomeService()
    }

    override func tearDownWithError() throws {
        homeService = nil
    }

    func testGetHomeSuccess() throws {
        let expectation = self.expectation(description: "fetch categories")

        HTTPStubs.stubRequests { request in
            request.url?.absoluteString.contains("https://api.chucknorris.io/jokes/categories") ?? false
        } withStubResponse: { _ in
            return HTTPStubsResponse(error: NSError(domain: "com.test.error", code: 404))
        }


        homeService.getHome { result in
            switch result {
            case .success:
                XCTFail("A request não pode cair no caso de success.")
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }

        waitForExpectations(timeout: 10)
        HTTPStubs.removeAllStubs()
    }

}
