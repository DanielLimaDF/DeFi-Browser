//
//  CollectionDataSource.swift
//  DeFi Browser
//
//  Created by Daniel Lima on 31/07/21.
//

import Foundation
import Reusable
import UIKit

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
