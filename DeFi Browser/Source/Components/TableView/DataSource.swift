//
//  DataSource.swift
//  DeFi Browser
//
//  Created by daniel.da.cunha.lima on 11/07/21.
//

import Foundation
import UIKit

public class DataSource: NSObject {

    let tableView: UITableView
    var dappsCount: Int
    var sections: [TableViewSectionProtocol] {
        didSet {
            sections.forEach {
                $0.registerCell(tableView)
            }
            tableView.reloadData()
        }
    }

    init(tableView: UITableView) {
        sections = []
        dappsCount = 0
        self.tableView = tableView
        super.init()
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension DataSource: UITableViewDataSource {

    public func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = sections[section]
        return section.title
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section]
        return section.numberOfRows
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        return section.cellFactory(tableView, indexPath)
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if indexPath.section == 0 {
            let size = (SizeToken.collectionCellSize * 2) + CGFloat(SizeToken.margingSmall)
            return size
        } else {
            return CGFloat(300)
        }

    }

}

extension DataSource: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = sections[indexPath.section]
        section.didSelectRow(for: indexPath)
    }

}
