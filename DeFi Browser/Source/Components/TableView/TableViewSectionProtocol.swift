//
//  TableViewSection.swift
//  DeFi Browser
//
//  Created by daniel.da.cunha.lima on 11/07/21.
//

import Foundation
import Reusable
import UIKit

protocol TableViewSectionProtocol {

    typealias HeaderFactory = (UITableView) -> UIView?
    typealias CellFactory = ((UITableView, IndexPath) -> UITableViewCell)

    var title: String? { get }
    var numberOfRows: Int { get }
    var registerCell: (UITableView) -> Void { get }
    var headerFactory: HeaderFactory { get }
    var cellFactory: CellFactory { get }
    var deleteAction: ((IndexPath) -> Void)? { get }

    func didSelectRow(for indexPath: IndexPath)
    func didDeleteRow(for indexPath: IndexPath)
}

extension TableViewSectionProtocol {
    func didSelectRow(for indexPath: IndexPath) {}
    func didDeleteRow(for indexPath: IndexPath) {}
}

class TableViewSection<T: UITableViewCell & CellProtocol & Reusable>: TableViewSectionProtocol {

    var title: String?
    var numberOfRows: Int
    var viewModels: [CellViewModelPrototol]
    var deleteAction: ((IndexPath) -> Void)?

    var registerCell: (UITableView) -> Void = { tableview in
        tableview.register(cellType: T.self)
    }
    
    var headerFactory: HeaderFactory {
        return { _ in
            if let sectionTitle = self.title {
                return self.headerView(sectionTitle: sectionTitle)
            }
            return nil
        }
    }

    var cellFactory: CellFactory {
        return { tableview, indexPath in
            var cell: T = tableview.dequeueReusableCell(for: indexPath)
            cell.viewModel = self.viewModels[indexPath.row]
            return cell
        }
    }

    init(title: String, viewModels: [CellViewModelPrototol]) {
        self.title = title
        self.viewModels = viewModels
        numberOfRows = viewModels.count
    }

    func didSelectRow(for indexPath: IndexPath) {
        let model = viewModels[indexPath.row]
        print(model.iconURL)
        model.didAction?()
    }
    
    func didDeleteRow(for indexPath: IndexPath) {
        deleteAction?(indexPath)
    }
    
    private func headerView(sectionTitle: String) -> UIView {
        let headerView = UIView()
        let titleLabel = UILabel()
        
        titleLabel.text = sectionTitle
        titleLabel.numberOfLines = 0
        titleLabel.textColor = ColorPalette.titleTextColor
        headerView.backgroundColor = ColorPalette.accentColor

        headerView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(headerView.snp.left)
            make.right.equalTo(headerView.snp.right)
            make.top.equalTo(headerView.snp.top)
        }
        
        return headerView
    }

}
