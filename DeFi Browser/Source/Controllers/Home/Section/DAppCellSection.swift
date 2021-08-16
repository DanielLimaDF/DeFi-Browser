//
//  DAppCellSection.swift
//  DeFi Browser
//
//  Created by daniel.da.cunha.lima on 17/07/21.
//

import Foundation
import UIKit

struct DAppCellSection: TableViewSectionProtocol {

    var title: String?
    var numberOfRows: Int
    var viewModels: [DAppCellViewModelProtocol]

    var registerCell: (UITableView) -> Void = { tableview in
        tableview.register(cellType: DAppCellView.self)
    }

    var cellFactory: CellFactory {
        return { tableview, indexPath in
            let cell: DAppCellView = tableview.dequeueReusableCell(for: indexPath)
            cell.viewModels = self.viewModels[indexPath.row].models
            return cell
        }
    }

    init(title: String?, viewModels: [DAppCellViewModelProtocol]) {
        self.title = title
        self.viewModels = viewModels
        numberOfRows = viewModels.count
    }

    func didSelectRow(for indexPath: IndexPath) {
        print("SELECTED \(indexPath.row)")
    }

}
