//
//  DataSourceTestCase.swift
//  DeFi BrowserTests
//
//  Created by Daniel Lima on 23/08/21.
//

import Foundation
import XCTest

@testable import DeFi_Browser

class DataSourceTestCase: XCTestCase {
    
    var sut: DataSource!
    var section: FakeTableviewSection!
    var models: [CellViewModelPrototol]!
    
    override func setUp() {
        super.setUp()
        
        models = []
        
        for _ in 0...9 {
            models.append(FakeCellViewModel())
        }
        
        section = FakeTableviewSection(models: models)
        sut = DataSource(tableView: UITableView())
        sut.sections = [section]
    }
    
    override func tearDown() {
        models = nil
        section = nil
        sut = nil
        super.tearDown()
    }
    
    func testNumberOfSections() {
        XCTAssertEqual(sut.numberOfSections(in: sut.tableView), 1)
    }
    
    func testNumberOfRowsInSection() {
        XCTAssertEqual(sut.tableView(sut.tableView, numberOfRowsInSection: 0), 10)
    }
    
    func testCellForRow() {
        XCTAssertNotNil(sut.tableView(sut.tableView, cellForRowAt: IndexPath(item: 0, section: 0)))
    }
    
    func testSectionTitle() {
        XCTAssertEqual(sut.tableView(sut.tableView, titleForHeaderInSection: 0), "Fake Title")
    }
    
    func testHeaderView() {
        XCTAssertNotNil(sut.tableView(sut.tableView, viewForHeaderInSection: 0))
    }
    
    func testCellSelection() {
        sut.tableView(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(section.selectedIndexPath, IndexPath(item: 0, section: 0))
    }
    
}
