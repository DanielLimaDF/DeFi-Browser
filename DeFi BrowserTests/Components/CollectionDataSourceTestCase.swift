//
//  CollectionDataSourceTestCase.swift
//  DeFi BrowserTests
//
//  Created by Daniel Lima on 29/08/21.
//

import Foundation
import XCTest

@testable import DeFi_Browser

class CollectionDataSourceTestCase: XCTestCase {
    
    var sut: CollectionDataSource!
    var section: FakeCollectionviewSection!
    var models: [CellViewModelPrototol]!
    
    override func setUp() {
        super.setUp()
        
        models = []
        
        for _ in 0...9 {
            models.append(FakeCellViewModel())
        }
        
        section = FakeCollectionviewSection(models: models)
        sut = CollectionDataSource(collection: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()))
        sut.sections = [section]
    }
    
    override func tearDown() {
        models = nil
        section = nil
        sut = nil
        super.tearDown()
    }
    
    func testNumberOfSections() {
        XCTAssertEqual(sut.numberOfSections(in: sut.collectionView), 1)
    }
    
    func testNumberOfItemsInSection() {
        XCTAssertEqual(sut.collectionView(sut.collectionView, numberOfItemsInSection: 0), 10)
    }
    
    func testCellForRow() {
        XCTAssertNotNil(sut.collectionView(sut.collectionView, cellForItemAt: IndexPath(item: 0, section: 0)))
    }
    
    func testItemSelection() {
        sut.collectionView(sut.collectionView, didSelectItemAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(section.selectedIndexPath, IndexPath(row: 0, section: 0))
    }
    
}
