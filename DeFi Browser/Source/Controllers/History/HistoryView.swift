//
//  HistoryView.swift
//  DeFi Browser
//
//  Created by Daniel Lima on 23/08/21.
//

import Foundation
import SnapKit
import UIKit

class HistoryView: UIView {

    var viewModel: HistoryViewModelProtocol? {
        didSet {
            update()
        }
    }

    let tableView: UITableView

    private let adapter: DataSource

    required init() {
        tableView = UITableView()
        adapter = DataSource(tableView: tableView)
        super.init(frame: CGRect.zero)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func update() {
        if let model = viewModel {
            adapter.sections = model.sections
        }
    }

}

extension HistoryView: ViewCoding {

    func buildViewHierarchy() {
        addSubview(tableView)
    }

    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.left.equalTo(snp.left).inset(SizeToken.margingMedium)
            make.right.equalTo(snp.right).inset(SizeToken.margingMedium)
            make.top.equalTo(safeAreaLayoutGuide.snp.topMargin)
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
