//
//  BrowserHTMLParserTestCase.swift
//  DeFi BrowserTests
//
//  Created by Daniel Lima on 23/08/21.
//

import Foundation
import XCTest

@testable import DeFi_Browser

class BrowserHTMLParserTestCase: XCTestCase {
    
    var sut: BrowserHTMLParser!
    
    override func setUp() {
        super.setUp()
        sut = BrowserHTMLParser()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testParse() throws {
        var item: DefiItem?
        let file = Bundle(for: object_getClass(self)!).path(forResource: "htmlWebsite", ofType: "html")
        let html = try String(contentsOfFile: file!, encoding: .utf8)
        sut.parse(html: html, url: URL(string: "https://test.com")!) { result in
            switch result {
            case let .success(value):
                item = value
            case .failure:
                item = nil
            }
        }
        
        XCTAssertNotNil(item)
        XCTAssertEqual(item?.title, "FakePageTitle")
        XCTAssertEqual(item?.description, "FakeDescription")
        XCTAssertEqual(item?.iconURL, "https://test.com/logo512.png")
        XCTAssertEqual(item?.url, "https://test.com")
    }
    
}
