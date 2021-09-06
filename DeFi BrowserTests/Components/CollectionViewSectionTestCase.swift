//
//  CollectionViewSectionTestCase.swift
//  DeFi BrowserTests
//
//  Created by Daniel Lima on 23/08/21.
//

import Foundation
import XCTest

@testable import DeFi_Browser

class CollectionViewSectionTestCase: XCTestCase {
    
    var sut: CollectionViewSection!
    var models: [CellViewModelPrototol]!
    var didCallSelectAction: Bool!
    
    override func setUp() {
        super.setUp()
        
        didCallSelectAction = false
        
        models = []
        
        for _ in 0...9 {
            models.append(CellViewModel(title: "Fake Title", subtitle: "Fake Subtitle", iconURL: "https://fake.url", didAction: {
                self.didCallSelectAction = true
            }))
        }
        
        sut = CollectionViewSection(viewModels: models)
    }
    
    override func tearDown() {
        sut = nil
        models = nil
        super.tearDown()
    }
    
    func testDidSelectRow() {
        sut.didSelectItem(for: IndexPath(item: 0, section: 0))
        XCTAssertTrue(didCallSelectAction)
    }
    
}
