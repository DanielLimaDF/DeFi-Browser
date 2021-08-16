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

    typealias CellFactory = ((UITableView, IndexPath) -> UITableViewCell)

    var title: String? { get }
    var numberOfRows: Int { get }
    var registerCell: (UITableView) -> Void { get }
    var cellFactory: CellFactory { get }

    func didSelectRow(for indexPath: IndexPath)
}

class TableViewSection<T: UITableViewCell & CellProtocol & Reusable>: TableViewSectionProtocol {

    var title: String?
    var numberOfRows: Int
    var viewModels: [CellViewModelPrototol]

    var registerCell: (UITableView) -> Void = { tableview in
        tableview.register(cellType: T.self)
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
        print("SELECTED \(indexPath.row)")
    }

}
