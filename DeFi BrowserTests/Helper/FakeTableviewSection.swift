//
//  FakeTableviewSection.swift
//  DeFi BrowserTests
//
//  Created by Daniel Lima on 01/09/21.
//

import Foundation
import XCTest

@testable import DeFi_Browser

internal struct FakeCellViewModel: CellViewModelPrototol {
    var title: String
    var subtitle: String
    var iconURL: String
    var didAction: (() -> Void)?
    
    init() {
        title = "Fake Title"
        subtitle = "Fake Subtitle"
        iconURL = "http://fake.url/icon.png"
    }
}

internal class FakeTableviewSection: TableViewSectionProtocol {
    
    var title: String?
    var numberOfRows: Int
    var viewModels: [CellViewModelPrototol]
    var deleteAction: ((IndexPath) -> Void)?
    var selectedIndexPath: IndexPath?
    
    var registerCell: (UITableView) -> Void = { _ in }
    
    var headerFactory: HeaderFactory {
        return { _ in
            return UIView(frame: .zero)
        }
    }
    
    var cellFactory: CellFactory {
        return { _, _ in
            return UITableViewCell()
        }
    }
    
    internal init(models: [CellViewModelPrototol]) {
        title = "Fake Title"
        viewModels = models
        numberOfRows = models.count
    }
    
    func didSelectRow(for indexPath: IndexPath) {
        selectedIndexPath = indexPath
    }
    
}

internal class FakeCollectionviewSection: CollectionViewSectionProtocol {
    
    var numberOfItems: Int
    var selectedIndexPath: IndexPath?
    
    var registerCell: (UICollectionView) -> Void = { _ in }
    
    var cellFactory: CellFactory {
        return { _, _ in
            return UICollectionViewCell()
        }
    }
    
    init(models: [CellViewModelPrototol]) {
        numberOfItems = models.count
    }
    
    func didSelectItem(for indexPath: IndexPath) {
        selectedIndexPath = indexPath
    }

}
