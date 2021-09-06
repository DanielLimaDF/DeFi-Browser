//
//  HomeView.swift
//  DeFi Browser
//
//  Created by Daniel Lima on 20/06/21.
//

import Foundation
import SnapKit
import UIKit

protocol HomeViewDelegate: AnyObject {
    func didSelectURL(url: URL)
    func didSelectSearch(text: String)
}

class HomeView: UIView {

    weak var delegate: HomeViewDelegate?
    var viewModel: HomeViewModelProtocol? {
        didSet {
            update()
        }
    }

    let header: HomeSearchHeaderView
    let tableView: UITableView

    private let adapter: DataSource

    required init() {
        header = HomeSearchHeaderView()
        tableView = UITableView()
        adapter = DataSource(tableView: tableView, collectionOnFirstSection: true)
        super.init(frame: CGRect.zero)
        setupView()
        header.searchBar.delegate = self
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func update() {
        if let model = viewModel {
            adapter.dappsCount = model.dappsCount
            adapter.sections = model.sections
        }
    }

}

extension HomeView: ViewCoding {

    func buildViewHierarchy() {
        addSubview(header)
        addSubview(tableView)
    }

    func setupConstraints() {
        header.snp.makeConstraints { make in
            make.left.equalTo(snp.left).inset(SizeToken.margingSmall)
            make.right.equalTo(snp.right).inset(SizeToken.margingSmall)
            make.top.equalTo(safeAreaLayoutGuide.snp.topMargin)
            make.height.equalTo(SizeToken.serchbarHeight)
        }

        tableView.snp.makeConstraints { make in
            make.left.equalTo(snp.left).inset(SizeToken.margingMedium)
            make.right.equalTo(snp.right).inset(SizeToken.margingMedium)
            make.top.equalTo(header.snp.bottomMargin)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottomMargin)
        }
    }

    func render() {
        backgroundColor = ColorPalette.accentColor

        tableView.backgroundColor = ColorPalette.accentColor
        tableView.tableFooterView = UIView()
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsMultipleSelectionDuringEditing = false
    }

}

extension HomeView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard var text = searchBar.text else {
            return
        }
        
        searchBar.resignFirstResponder()
        text = text.replacingOccurrences(of: "http://", with: "https://")
        
        if let url = URL(string: text), UIApplication.shared.canOpenURL(url) {
            delegate?.didSelectURL(url: url)
            return
        }
        
        delegate?.didSelectSearch(text: text)
    }
}
