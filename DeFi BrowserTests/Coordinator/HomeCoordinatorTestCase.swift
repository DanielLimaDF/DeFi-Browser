//
//  HomeCoordinatorTestCase.swift
//  DeFi BrowserTests
//
//  Created by Daniel Lima on 01/09/21.
//

import Foundation
import XCTest

@testable import DeFi_Browser

class HomeCoordinatorTestCase: XCTestCase {
    
    var sut: HomeCoordinator!
    
    override func setUp() {
        super.setUp()
        sut = HomeCoordinator(databaseService: FakeDatabaseService())
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testViewControllerType() {
        XCTAssertTrue(sut.rootViewController.viewControllers.first is HomeViewController)
    }
    
}
