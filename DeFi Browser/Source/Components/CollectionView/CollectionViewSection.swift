//
//  CollectionViewSection.swift
//  DeFi Browser
//
//  Created by Daniel Lima on 29/08/21.
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
        collectionView.register(cellType: DAppCollectionViewCell.self)
    }

    var cellFactory: CellFactory {
        return { collectionView, indexPath in
            let cell: DAppCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.viewModel = self.viewModels[indexPath.row]
            return cell
        }
    }

    init(viewModels: [CellViewModelPrototol]) {
        self.viewModels = viewModels
        numberOfItems = viewModels.count
    }

    func didSelectItem(for indexPath: IndexPath) {
        let model = viewModels[indexPath.row]
        model.didAction?()
    }

}
