//
//  HistoryViewControllerTestCase.swift
//  DeFi BrowserTests
//
//  Created by Daniel Lima on 04/09/21.
//

import Foundation
import XCTest

@testable import DeFi_Browser

class HistoryViewControllerTestCase: XCTestCase {
    
    var sut: HistoryViewController!
    var databaseService: FakeDatabaseService!
    var fakeCoordinator: FakeCoordinator<HistoryAction>!
    
    override class func setUp() {
        super.setUp()
        let setupDatabase = FakeDatabaseService()
        setupDatabase.addHistory(item: DefiItem(title: "HistoryItem", description: "HistoryItem", iconURL: "https://fake.com/icon.png", url: "https://fake.com"))
    }
    
    override func setUp() {
        super.setUp()
        databaseService = FakeDatabaseService()
        sut = HistoryViewController(databaseService: databaseService)
        fakeCoordinator = FakeCoordinator(controller: sut)
    }
    
    override func tearDown() {
        fakeCoordinator = nil
        databaseService = nil
        sut = nil
        super.tearDown()
    }
    
    
    func testDefaultValues() {
        XCTAssertEqual(sut.title, "History")
        XCTAssertEqual(sut.historyRegisters.count, 3)
        XCTAssertTrue(sut.view is HistoryView)
    }
    
    
    func testNavigationSetup() throws {
        let navigationController = try XCTUnwrap(sut.navigationController)
        
        XCTAssertTrue(navigationController.navigationBar.prefersLargeTitles)
        XCTAssertEqual(navigationController.navigationBar.tintColor, ColorPalette.buttonColor)
        XCTAssertNil(sut.navigationItem.leftBarButtonItem)
        XCTAssertNotNil(sut.navigationItem.rightBarButtonItem)
        
        XCTAssertEqual(navigationController.navigationBar.standardAppearance.backgroundColor, ColorPalette.accentColor)
        XCTAssertEqual(navigationController.navigationBar.standardAppearance.titleTextAttributes[NSAttributedString.Key.foregroundColor] as? UIColor, ColorPalette.titleTextColor)
        XCTAssertEqual(navigationController.navigationBar.standardAppearance.largeTitleTextAttributes[NSAttributedString.Key.foregroundColor] as? UIColor, ColorPalette.titleTextColor)
        XCTAssertEqual(navigationController.navigationBar.standardAppearance.shadowColor, ColorPalette.accentColor)
        
        XCTAssertEqual(navigationController.navigationBar.compactAppearance?.backgroundColor, ColorPalette.accentColor)
        XCTAssertEqual(navigationController.navigationBar.compactAppearance?.titleTextAttributes[NSAttributedString.Key.foregroundColor] as? UIColor, ColorPalette.titleTextColor)
        XCTAssertEqual(navigationController.navigationBar.compactAppearance?.largeTitleTextAttributes[NSAttributedString.Key.foregroundColor] as? UIColor, ColorPalette.titleTextColor)
        XCTAssertEqual(navigationController.navigationBar.compactAppearance?.shadowColor, ColorPalette.accentColor)
        
        XCTAssertEqual(navigationController.navigationBar.scrollEdgeAppearance?.backgroundColor, ColorPalette.accentColor)
        XCTAssertEqual(navigationController.navigationBar.scrollEdgeAppearance?.titleTextAttributes[NSAttributedString.Key.foregroundColor] as? UIColor, ColorPalette.titleTextColor)
        XCTAssertEqual(navigationController.navigationBar.scrollEdgeAppearance?.largeTitleTextAttributes[NSAttributedString.Key.foregroundColor] as? UIColor, ColorPalette.titleTextColor)
        XCTAssertEqual(navigationController.navigationBar.scrollEdgeAppearance?.shadowColor, ColorPalette.accentColor)
        
    }
    
    
    func testClearToolbarItem() throws {
        let toolBarItem = try XCTUnwrap(sut.navigationItem.rightBarButtonItem)
        XCTAssertEqual(toolBarItem.image, IconLibrary.trash)
    }
    
    func testActionHistorySelection() throws {
        let historyModel = try XCTUnwrap(((sut.view as? HistoryView)?.viewModel?.sections[0] as? TableViewSection<BookmarkCellView>)?.viewModels[0])
        historyModel.didAction?()
        
        XCTAssertEqual(
            fakeCoordinator.lastHistoryItem,
            DefiItem(
                title: "HistoryItem",
                description: "HistoryItem",
                iconURL: "https://fake.com/icon.png",
                url: "https://fake.com"
            )
        )
    }
    
    func testDeleteHistory() {
        sut.deleteHistory(historyItem: sut.historyRegisters[0])
        XCTAssertEqual(sut.historyRegisters.count, 2)
    }
    
    func testClearHistory() {
        sut.clearHistory()
        XCTAssertNotNil(fakeCoordinator.lastAction)
    }
    
}
