//
//  BrowserViewTestCase.swift
//  DeFi BrowserTests
//
//  Created by Daniel Lima on 02/09/21.
//

import Foundation
import XCTest

@testable import DeFi_Browser

class BrowserViewTestCase: XCTestCase {
    
    var sut: BrowserView!
    
    override func setUp() {
        super.setUp()
        
        sut = BrowserView()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testDefaultSetup() {
        XCTAssertEqual(sut.backgroundColor, ColorPalette.accentColor)
        XCTAssertEqual(sut.toolBar.barTintColor, ColorPalette.accentColor)
        XCTAssertEqual(sut.toolBar.tintColor, ColorPalette.buttonColor)
        XCTAssertFalse(sut.webView.isOpaque)
    }
    
    func testToolBarItems() {
        XCTAssertEqual(sut.toolBar.items?.count, 5)
        XCTAssertEqual(sut.toolBar.items?[0].image, IconLibrary.chevronBackward)
        XCTAssertEqual(sut.toolBar.items?[2].image, IconLibrary.chevronForward)
        XCTAssertEqual(sut.toolBar.items?[4].image, IconLibrary.clockwiseArrow)
    }
    
    func testToolbarFixedSpace() throws {
        let toolBarItem = try XCTUnwrap(sut.toolBar.items?[1])
        XCTAssertTrue(toolBarItem.description.contains("systemItem=FixedSpace"))
    }
    
    func testToolbarFlexibleSpace() throws {
        let toolBarItem = try XCTUnwrap(sut.toolBar.items?[3])
        XCTAssertTrue(toolBarItem.description.contains("systemItem=FlexibleSpace"))
    }
    
}
