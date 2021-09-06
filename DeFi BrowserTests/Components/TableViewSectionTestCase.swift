//
//  TableViewSectionTestCase.swift
//  DeFi BrowserTests
//
//  Created by Daniel Lima on 23/08/21.
//

import Foundation
import XCTest

@testable import DeFi_Browser

class TableViewSectionTestCase: XCTestCase {
    
    var sut: TableViewSection<BookmarkCellView>!
    var models: [CellViewModelPrototol]!
    var didCallSelectAction: Bool!
    var didCallDeleteAction: Bool!
    
    override func setUp() {
        super.setUp()
        
        didCallSelectAction = false
        didCallDeleteAction = false
        
        models = []
        
        for _ in 0...9 {
            models.append(CellViewModel(title: "Fake Title", subtitle: "Fake Subtitle", iconURL: "https://fake.url", didAction: {
                self.didCallSelectAction = true
            }))
        }
        
        sut = TableViewSection(title: "Fake Title", viewModels: models)
        sut.deleteAction = { _ in
            self.didCallDeleteAction = true
        }
    }
    
    override func tearDown() {
        sut = nil
        models = nil
        super.tearDown()
    }
    
    func testDidSelectRow() {
        sut.didSelectRow(for: IndexPath(row: 0, section: 0))
        XCTAssertTrue(didCallSelectAction)
    }
    
    func testDidDeleteRow() {
        sut.didDeleteRow(for: IndexPath(row: 0, section: 0))
        XCTAssertTrue(didCallDeleteAction)
    }
    
}
