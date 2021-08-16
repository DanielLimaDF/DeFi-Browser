//
//  HomeSearchHeaderView.swift
//  DeFi Browser
//
//  Created by daniel.da.cunha.lima on 11/07/21.
//

import Foundation
import UIKit

class HomeSearchHeaderView: UIView {

    let searchBar: UISearchBar

    required init() {
        searchBar = UISearchBar()
        super.init(frame: CGRect.zero)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension HomeSearchHeaderView: ViewCoding {

    func buildViewHierarchy() {
        addSubview(searchBar)
    }

    func setupConstraints() {
        searchBar.snp.makeConstraints { make in
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            make.top.equalTo(snp.top)
            make.bottom.equalTo(snp.bottom)
        }
    }

    func render() {
        backgroundColor = ColorPalette.accentColor
        searchBar.searchBarStyle = .minimal
    }

}
