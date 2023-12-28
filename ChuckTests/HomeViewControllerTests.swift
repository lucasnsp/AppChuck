//
//  HomeViewControllerTests.swift
//  ChuckTests
//
//  Created by Lucas Neves dos santos pompeu on 28/12/23.
//

import XCTest
@testable import Chuck

final class HomeViewControllerTests: XCTestCase {

    var viewController: HomeViewController!
    var tableView: UITableView!
    var tableViewMock: TableViewMock!

    override func setUpWithError() throws {
        viewController = HomeViewController()
        tableView = UITableView()
        viewController.tableView = tableView
        viewController.configTableView()
        tableViewMock = TableViewMock()
    }

    override func tearDownWithError() throws {
        viewController = nil
        tableView = nil
        tableViewMock = nil
    }

    func testConfigTableView() throws {
        XCTAssertTrue(viewController.tableView.delegate is HomeViewController)
        XCTAssertTrue(viewController.tableView.dataSource is HomeViewController)
    }

    func testNumberOfRowsInSection() {
        tableViewMock.dataSource = viewController
        tableViewMock.delegate = viewController

        XCTAssertEqual(tableViewMock.cellForRowAtIndexPathCallCount, 0)
        _ = tableViewMock.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertEqual(tableViewMock.cellForRowAtIndexPathCallCount, 1)
    }

    func testCellForRowAtIndexPath() {
        tableViewMock.dataSource = viewController
        tableViewMock.delegate = viewController

        XCTAssertEqual(tableViewMock.numberOfRowsInSectionCallCount, 0)
        _ = tableViewMock.numberOfRows(inSection: 0)
        XCTAssertEqual(tableViewMock.numberOfRowsInSectionCallCount, 1)
    }

}

class TableViewMock: UITableView {
    var numberOfRowsInSectionCallCount = 0
    var cellForRowAtIndexPathCallCount = 0

    override func numberOfRows(inSection section: Int) -> Int {
        numberOfRowsInSectionCallCount += 1
        return super.numberOfRows(inSection: section)
    }

    override func cellForRow(at indexPath: IndexPath) -> UITableViewCell? {
        cellForRowAtIndexPathCallCount += 1
        return super.cellForRow(at: indexPath)
    }
}
