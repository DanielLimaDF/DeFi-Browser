//
//  HomeViewModel.swift
//  DeFi Browser
//
//  Created by daniel.da.cunha.lima on 11/07/21.
//

import Foundation
import UIKit

protocol HomeViewModelProtocol {
    var sections: [TableViewSectionProtocol] { get }
    var dappsCount: Int { get }
}

struct HomeViewModel: HomeViewModelProtocol {
    var sections: [TableViewSectionProtocol]
    var dappsCount: Int

    init(deFiItems: [DefiItem]) {

        let deFiViewModels = deFiItems.map{ CellViewModel(title: $0.title, subtitle: $0.description, iconURL: $0.iconURL) }
        let dAppsViewModels = DAppCellViewModel(models: deFiViewModels)
        //let favoriteViewModels

        let dAppsSection = DAppCellSection(title: nil, viewModels: [dAppsViewModels])
        //let favoriteSection: TableViewSection<FavoriteCellView> = TableViewSection(title: "Bookmarks", viewModels: favoriteViewModels)

        dappsCount = deFiViewModels.count
        sections = [dAppsSection]
    }
}
