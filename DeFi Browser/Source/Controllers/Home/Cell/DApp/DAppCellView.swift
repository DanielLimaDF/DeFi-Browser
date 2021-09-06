//
//  DAppCellView.swift
//  DeFi Browser
//
//  Created by Daniel Lima on 17/07/21.
//

import Foundation
import Reusable
import UIKit

class DAppCellView: UITableViewCell, Reusable {

    var viewModels: [CellViewModelPrototol]? {
        didSet {
            update()
        }
    }

    let collectionView: UICollectionView
    let flowLayout: UICollectionViewFlowLayout

    private let adatper: CollectionDataSource

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        flowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        adatper = CollectionDataSource(collection: collectionView)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func update() {
        if let models = viewModels {
            let section = CollectionViewSection(viewModels: models)
            adatper.sections = [section]
        }
    }

}

extension DAppCellView: ViewCoding {

    func buildViewHierarchy() {
        contentView.addSubview(collectionView)
    }

    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.bottom.equalTo(contentView.snp.bottom)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
        }
    }

    func render() {
        selectionStyle = .none
        backgroundColor = .clear

        collectionView.backgroundColor = .clear
        collectionView.bounces = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false

        flowLayout.minimumLineSpacing = CGFloat(SizeToken.margingSmall)
        flowLayout.minimumInteritemSpacing = CGFloat(SizeToken.margingSmall)
        flowLayout.itemSize = CGSize(width: SizeToken.collectionCellSize, height: SizeToken.collectionCellSize)
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            flowLayout.scrollDirection = .horizontal
            collectionView.bounces = true
        }
    }

}
