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
    let isFirstSectionACollection: Bool
    var dappsCount: Int
    var sections: [TableViewSectionProtocol] {
        didSet {
            sections.forEach {
                $0.registerCell(tableView)
            }
            tableView.reloadData()
        }
    }

    init(tableView: UITableView, collectionOnFirstSection: Bool = false) {
        sections = []
        dappsCount = 0
        isFirstSectionACollection = collectionOnFirstSection
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
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(SizeToken.margingMedium)
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if indexPath.section == 0 && isFirstSectionACollection {
            let size = (SizeToken.collectionCellSize * 2) + CGFloat(SizeToken.margingSmall)
            return size
        } else {
            return UITableView.automaticDimension
        }

    }

}

extension DataSource: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = sections[section]
        return section.headerFactory(tableView)
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = sections[indexPath.section]
        section.didSelectRow(for: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 0 && isFirstSectionACollection {
            return false
        } else {
            return true
        }
    }
    
    public func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: String()) { [weak self] (action, view, completion) in
            
            let section = self?.sections[indexPath.section]
            section?.didDeleteRow(for: indexPath)
            
            completion(true)
        }
        action.backgroundColor = ColorPalette.accentColor
        
        let image = IconLibrary.minus?.withRenderingMode(.alwaysOriginal).withTintColor(.red)
        action.image = image
        
        let config = UISwipeActionsConfiguration(actions: [action])
        return config
    }

}
