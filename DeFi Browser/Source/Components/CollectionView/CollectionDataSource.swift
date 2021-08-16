//
//  CollectionDataSource.swift
//  DeFi Browser
//
//  Created by daniel.da.cunha.lima on 31/07/21.
//

import Foundation
import Reusable
import UIKit

protocol CollectionViewSectionProtocol {
    typealias CellFactory = ((UICollectionView, IndexPath) -> UICollectionViewCell)

    var numberOfItems: Int { get }
    var registerCell: (UICollectionView) -> Void { get }
    var cellFactory: CellFactory { get }

    func didSelectItem(for indexPath: IndexPath)
}

class CollectionViewSection: CollectionViewSectionProtocol {

    var numberOfItems: Int
    var viewModels: [CellViewModelPrototol]

    var registerCell: (UICollectionView) -> Void = { collectionView in
        collectionView.register(cellType: DAppCollectionCellView.self)
    }

    var cellFactory: CellFactory {
        return { collectionView, indexPath in
            let cell: DAppCollectionCellView = collectionView.dequeueReusableCell(for: indexPath)
            cell.viewModel = self.viewModels[indexPath.row]
            return cell
        }
    }

    init(viewModels: [CellViewModelPrototol]) {
        self.viewModels = viewModels
        numberOfItems = viewModels.count
    }

    func didSelectItem(for indexPath: IndexPath) {
        print("SELECTED IN COLLECTION \(indexPath.row)")
    }

}

class CollectionDataSource: NSObject {

    let collectionView: UICollectionView
    var sections: [CollectionViewSectionProtocol] {
        didSet {
            sections.forEach {
                $0.registerCell(collectionView)
            }
            collectionView.reloadData()
        }
    }

    init(collection: UICollectionView) {
        sections = []
        collectionView = collection
        super.init()
        collectionView.delegate = self
        collectionView.dataSource = self
    }

}

extension CollectionDataSource: UICollectionViewDataSource {

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = sections[section]
        return section.numberOfItems
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sections[indexPath.section]
        return section.cellFactory(collectionView, indexPath)
    }


}

extension CollectionDataSource: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = sections[indexPath.section]
        section.didSelectItem(for: indexPath)
    }

}
