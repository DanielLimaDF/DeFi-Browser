//
//  DAppSection.swift
//  DeFi Browser
//
//  Created by daniel.da.cunha.lima on 17/07/21.
//

import Foundation
import SnapKit
import UIKit

struct DAppSection: TableViewSectionProtocol {

    var title: String?
    var numberOfRows: Int
    var viewModels: [DAppCellViewModelProtocol]
    var deleteAction: ((IndexPath) -> Void)?

    var registerCell: (UITableView) -> Void = { tableview in
        tableview.register(cellType: DAppCellView.self)
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
