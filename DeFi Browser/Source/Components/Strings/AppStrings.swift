//
//  AppStrings.swift
//  DeFi Browser
//
//  Created by Daniel Lima on 19/08/21.
//

import Foundation

enum AppStrings: String {
    
    case HomeDappsSectionTitle = "Home.DAppsSectionTitle"
    case HomeBookmarksSectionTitle = "Home.BookmarksSectionTitle"
    case TabbarDefi = "Tabbar.Defi"
    case TabbarHistory = "Tabbar.History"
    case HistoryToday = "History.Today"
    case HistoryClearTitle = "History.ClearTitle"
    case HistoryClearMessage = "History.ClearMessage"
    case HistoryClearCancelButton = "History.ClearCancelButton"
    case HistoryClearConfirmButton = "History.ClearConfirmButton"
    
    func localizedString() -> String {
        return NSLocalizedString(self.rawValue, comment: String())
    }
}
