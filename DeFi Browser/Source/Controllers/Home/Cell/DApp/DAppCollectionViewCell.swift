//
//  DAppCollectionViewCell.swift
//  DeFi Browser
//
//  Created by Daniel Lima on 31/07/21.
//

import Foundation
import Kingfisher
import Reusable
import UIKit

class DAppCollectionViewCell: UICollectionViewCell, Reusable {

    var viewModel: CellViewModelPrototol? {
        didSet {
            update()
        }
    }

    let imageView: UIImageView

    override init(frame: CGRect) {
        imageView = UIImageView()
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func update() {
        if let model = viewModel, let iconURL = URL(string: model.iconURL) {
            imageView.kf.setImage(with: iconURL)
        }
    }

}

extension DAppCollectionViewCell: ViewCoding {

    func buildViewHierarchy() {
        addSubview(imageView)
    }

    func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).inset(SizeToken.margingMedium)
            make.left.equalTo(snp.left).inset(SizeToken.margingMedium)
            make.right.equalTo(snp.right).inset(SizeToken.margingMedium)
            make.bottom.equalTo(snp.bottom).inset(SizeToken.margingMedium)
        }
    }

    func render() {
        backgroundColor = ColorPalette.interactionColor
        layer.cornerRadius = frame.size.width * 0.1

        imageView.layer.cornerRadius = (CGFloat(SizeToken.collectionCellSize) - (CGFloat(SizeToken.margingMedium) * 2)) / 2
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
    }

}
