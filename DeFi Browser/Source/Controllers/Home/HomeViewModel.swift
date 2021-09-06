//
//  HomeViewModel.swift
//  DeFi Browser
//
//  Created by Daniel Lima on 11/07/21.
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

    init(deFiItems: [DefiItem], bookmarkItems: [DefiItem], action: @escaping (HomeAction) -> Void) {

        let deFiViewModels = deFiItems.map{ data -> CellViewModel in
            var model = CellViewModel(
                title: data.title,
                subtitle: data.description,
                iconURL: data.iconURL
            )
            
            model.didAction = {
                action(.goToItem(defiItem: data))
            }
            
            return model
        }
        let dAppsViewModels = DAppCellViewModel(models: deFiViewModels)
        let bookmarkModels = bookmarkItems.compactMap({ item in
            CellViewModel(title: item.title, subtitle: item.cleanBaseURL(), iconURL: item.iconURL) {
                action(.goToItem(defiItem: item))
            }
        })

        let dAppsSection = DAppSection(
            title: AppStrings.HomeDappsSectionTitle.localizedString(),
            viewModels: [dAppsViewModels]
        )
        let bookmarksSection: TableViewSection<BookmarkCellView> = TableViewSection(
            title: AppStrings.HomeBookmarksSectionTitle.localizedString(),
            viewModels: bookmarkModels
        )
        
        bookmarksSection.deleteAction = { indexPath in
            action(.delete(item: bookmarkItems[indexPath.row]))
        }

        dappsCount = deFiViewModels.count
        sections = [dAppsSection, bookmarksSection]
    }
}
