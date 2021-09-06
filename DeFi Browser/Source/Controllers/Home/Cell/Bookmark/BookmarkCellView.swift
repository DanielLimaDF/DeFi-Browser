//
//  BookmarkCellView.swift
//  DeFi Browser
//
//  Created by Daniel Lima on 21/08/21.
//

import Foundation
import Reusable
import UIKit

class BookmarkCellView: UITableViewCell, CellProtocol, Reusable {
    
    var viewModel: CellViewModelPrototol? {
        didSet {
            update()
        }
    }
    
    let conteinerView: UIView
    let iconConteinerView: UIView
    let iconImageView: UIImageView
    let titleLabel: UILabel
    let subtitleLabel: UILabel
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        conteinerView = UIView()
        iconConteinerView = UIView()
        iconImageView = UIImageView()
        titleLabel = UILabel()
        subtitleLabel = UILabel()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func update() {
        if let model = viewModel {
            
            if let iconURL = URL(string: model.iconURL) {
                iconImageView.kf.setImage(
                    with: iconURL,
                    placeholder: IconLibrary.questionMark?.withRenderingMode(.alwaysOriginal).withTintColor(ColorPalette.subtitleTextColor)
                )
            } else {
                iconImageView.image = IconLibrary.questionMark?.withRenderingMode(.alwaysOriginal).withTintColor(ColorPalette.subtitleTextColor)
            }
            
            titleLabel.text = model.title
            subtitleLabel.text = model.subtitle
        }
    }
    
}

extension BookmarkCellView: ViewCoding {

    func buildViewHierarchy() {
        addSubview(conteinerView)
        conteinerView.addSubview(iconConteinerView)
        iconConteinerView.addSubview(iconImageView)
        conteinerView.addSubview(titleLabel)
        conteinerView.addSubview(subtitleLabel)
    }

    func setupConstraints() {
        
        conteinerView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).inset(SizeToken.margingExtraSmall)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            make.bottom.equalTo(snp.bottom).inset(SizeToken.margingExtraSmall)
        }
        
        iconConteinerView.snp.makeConstraints { make in
            make.top.equalTo(conteinerView.snp.top).inset(SizeToken.margingMedium)
            make.left.equalTo(conteinerView.snp.left).inset(SizeToken.margingMedium)
            make.right.equalTo(iconImageView.snp.right).offset(SizeToken.margingSmall)
            make.bottom.equalTo(conteinerView.snp.bottom).inset(SizeToken.margingMedium)
        }
        
        let imageSize = (SizeToken.collectionCellSize - CGFloat(SizeToken.margingMedium * 2)) * 0.7
        iconImageView.snp.makeConstraints { make in
            make.top.equalTo(iconConteinerView.snp.top).inset(SizeToken.margingSmall)
            make.left.equalTo(iconConteinerView.snp.left).inset(SizeToken.margingSmall)
            make.bottom.equalTo(iconConteinerView.snp.bottom).inset(SizeToken.margingSmall)
            make.width.equalTo(imageSize)
            make.height.equalTo(imageSize)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(iconConteinerView.snp.right).offset(SizeToken.margingMedium)
            make.right.equalTo(conteinerView.snp.right).inset(SizeToken.margingMedium)
            make.bottom.equalTo(conteinerView.snp.centerY).inset(SizeToken.margingMedium)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.left.equalTo(iconConteinerView.snp.right).offset(SizeToken.margingMedium)
            make.right.equalTo(conteinerView.snp.right).inset(SizeToken.margingMedium)
            make.top.equalTo(conteinerView.snp.centerY).inset(SizeToken.margingMedium)
        }
        
    }

    func render() {
        backgroundColor = ColorPalette.accentColor
        
        titleLabel.textColor = ColorPalette.titleTextColor
        subtitleLabel.textColor = ColorPalette.subtitleTextColor
        
        iconConteinerView.backgroundColor = ColorPalette.accentColor
        iconConteinerView.layer.cornerRadius = SizeToken.collectionCellSize * 0.1
        
        conteinerView.backgroundColor = ColorPalette.interactionColor
        conteinerView.layer.cornerRadius = (SizeToken.collectionCellSize + CGFloat(SizeToken.margingMedium * 2)) * 0.1

        iconImageView.layer.cornerRadius = ((CGFloat(SizeToken.collectionCellSize) - (CGFloat(SizeToken.margingMedium) * 2)) * 0.7) / 2
        iconImageView.clipsToBounds = true
        iconImageView.contentMode = .scaleAspectFill
        
        selectionStyle = .none
    }

}
