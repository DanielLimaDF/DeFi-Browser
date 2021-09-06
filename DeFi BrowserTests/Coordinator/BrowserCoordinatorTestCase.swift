//
//  BrowserCoordinatorTestCase.swift
//  DeFi BrowserTests
//
//  Created by Daniel Lima on 01/09/21.
//

import Foundation
import XCTest

@testable import DeFi_Browser

class BrowserCoordinatorTestCase: XCTestCase {
    
    var sut: BrowserCoordinator!
    
    override func setUp() {
        super.setUp()
        sut = BrowserCoordinator(
            defiItem: DefiItem(
                title: "Fake Title",
                description: "Fake Description",
                iconURL: "https://fake.url/icon.png",
                url: "https://fake.browsercoordinator.url"),
            databaseService: FakeDatabaseService()
        )
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testViewControllerType() {
        XCTAssertTrue(sut.rootViewController.viewControllers.first is BrowserViewController)
    }
    
}
