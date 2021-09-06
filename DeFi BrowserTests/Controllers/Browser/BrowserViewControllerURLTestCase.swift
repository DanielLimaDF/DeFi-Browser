//
//  BrowserViewControllerURLTestCase.swift
//  DeFi BrowserTests
//
//  Created by Daniel Lima on 02/09/21.
//

import Foundation
import XCTest

@testable import DeFi_Browser

class BrowserViewControllerURLTestCase: XCTestCase {
    
    var sut: BrowserViewController!
    var databaseService: FakeDatabaseService!
    var fakeCoordinator: FakeCoordinator<BrowserAction>!
    
    override func setUp() {
        super.setUp()
        databaseService = FakeDatabaseService()
        
        let file = Bundle(for: object_getClass(self)!).path(forResource: "HTMLWebsite", ofType: "html")!
        let url = URL(fileURLWithPath: file)
        
        sut = BrowserViewController(url: url, parser: BrowserHTMLParser(), databaseService: databaseService)
        fakeCoordinator = FakeCoordinator(controller: sut)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testDefaultValues() {
        XCTAssertNil(sut.defiItem)
        XCTAssertNotNil(sut.url)
    }
    
    func testDidLoad() throws {
        let file = Bundle(for: object_getClass(self)!).path(forResource: "HTMLWebsite", ofType: "html")!
        let html = try String(contentsOfFile: file, encoding: .utf8)
        
        sut.didLoad(html: html)
        
        XCTAssertNotNil(sut.defiItem)
    }
    
}
