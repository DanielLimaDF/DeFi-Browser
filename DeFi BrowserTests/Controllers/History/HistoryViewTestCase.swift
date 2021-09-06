//
//  HistoryViewTestCase.swift
//  DeFi BrowserTests
//
//  Created by Daniel Lima on 04/09/21.
//

import Foundation
import XCTest

@testable import DeFi_Browser

class HistoryViewTestCase: XCTestCase {
    
    var sut: HistoryView!
    
    override func setUp() {
        super.setUp()
        
        sut = HistoryView()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testDefaultSetup() {
        XCTAssertEqual(sut.backgroundColor, ColorPalette.accentColor)
        XCTAssertEqual(sut.tableView.backgroundColor, ColorPalette.accentColor)
        XCTAssertEqual(sut.tableView.keyboardDismissMode, .onDrag)
        XCTAssertEqual(sut.tableView.separatorStyle, .none)
        XCTAssertFalse(sut.tableView.showsVerticalScrollIndicator)
        XCTAssertFalse(sut.tableView.allowsMultipleSelectionDuringEditing)
    }
    
}
