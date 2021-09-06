//
//  BrowserViewControllerTestCase.swift
//  DeFi BrowserTests
//
//  Created by Daniel Lima on 02/09/21.
//

import Foundation
import XCTest

@testable import DeFi_Browser

class BrowserViewControllerTestCase: XCTestCase {
    
    var sut: BrowserViewController!
    var databaseService: FakeDatabaseService!
    var fakeCoordinator: FakeCoordinator<BrowserAction>!
    
    override func setUp() {
        super.setUp()
        databaseService = FakeDatabaseService()
        sut = BrowserViewController(
            defiItem: DefiItem(title: "Fake Title", description: "Fake Description", iconURL: "https://fake.url/icon.png", url: "https://fake.browserviewcontroller.url"),
            parser: BrowserHTMLParser(),
            databaseService: databaseService
        )
        fakeCoordinator = FakeCoordinator(controller: sut)
    }
    
    override func tearDown() {
        fakeCoordinator = nil
        databaseService = nil
        sut = nil
        super.tearDown()
    }
    
    func testDefaultValues() {
        XCTAssertNotNil(sut.defiItem)
        XCTAssertNil(sut.url)
        XCTAssertTrue(sut.view is BrowserView)
    }
    
    func testNavigationSetup() {
        XCTAssertEqual(sut.navigationController?.navigationBar.barTintColor, ColorPalette.accentColor)
        XCTAssertNotNil(sut.navigationItem.leftBarButtonItem)
        XCTAssertNotNil(sut.navigationItem.rightBarButtonItem)
    }
    
    func testDefaultBookmarkToolbarItem() throws {
        let toolBarItem = try XCTUnwrap(sut.navigationItem.rightBarButtonItem)
        XCTAssertEqual(toolBarItem.image, IconLibrary.star)
    }
    
    func testToggleBookmark() throws {
        sut.toggleBookmark()
        
        let toolBarItem = try XCTUnwrap(sut.navigationItem.rightBarButtonItem)
        
        XCTAssertEqual(toolBarItem.image, IconLibrary.starFill)
    }
    
    func testAddHistory() {
        sut.addHistoryRegister()
        
        XCTAssertTrue(databaseService.wasAddHistoryCalled)
    }
    
    func testAddBookmark() {
        sut.toggleBookmark()
        
        XCTAssertTrue(databaseService.wasAddBookmarkCalled)
    }
    
    func testCloseAction() {
        sut.close()
        
        XCTAssertEqual(fakeCoordinator.lastAction, BrowserAction.dismiss)
    }
    
}
