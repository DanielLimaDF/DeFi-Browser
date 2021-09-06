//
//  DefiRouterTestCase.swift
//  DeFi BrowserTests
//
//  Created by Daniel Lima on 23/08/21.
//

import XCTest

@testable import DeFi_Browser

class DefiRouterTestCase: XCTestCase {
    
    var sut: DefiRouter!
    
    override func setUp() {
        super.setUp()
        sut = DefiRouter.list
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testHTTPMethod() {
        XCTAssertEqual(sut.method, .get)
    }
    
    func testPath() {
        XCTAssertEqual(sut.path, "https://gist.githubusercontent.com/DanielLimaDF/4f2b319d04ff99950fed9eb4d554d91c/raw/8e36131e13e0dc6117d75c10d917f09918153c85/DeFiList.json")
    }
    
    func testParametersNotNil() {
        XCTAssertNil(sut.parameters)
    }
    
    func testURL() {
        let request = try? sut.urlRequest()
        XCTAssertEqual(request?.url?.absoluteString, "https://gist.githubusercontent.com/DanielLimaDF/4f2b319d04ff99950fed9eb4d554d91c/raw/8e36131e13e0dc6117d75c10d917f09918153c85/DeFiList.json")
    }
    
}
