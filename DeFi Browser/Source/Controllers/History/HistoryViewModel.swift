//
//  HistoryViewModel.swift
//  DeFi Browser
//
//  Created by Daniel Lima on 23/08/21.
//

import Foundation
import UIKit

protocol HistoryViewModelProtocol {
    var sections: [TableViewSectionProtocol] { get }
}

struct HistoryViewModel: HistoryViewModelProtocol {
    var sections: [TableViewSectionProtocol]

    init(historyItems: [HistoryItemDao], action: @escaping (HistoryAction) -> Void) {
        
        let groupedItems = Dictionary(grouping: historyItems, by: { $0.date.toString() })
        let todayDate = Date().toString()
        
        sections = groupedItems.compactMap({ element in
            
            let sortedItems = element.value.sorted{ $0.date > $1.date }
            
            let models: [CellViewModel] = sortedItems.compactMap({ value in
                let item = value.item()
                return CellViewModel(title: value.title, subtitle: item.cleanBaseURL(), iconURL: item.iconURL) {
                    action(.goToItem(defiItem: item))
                }
            })
            
            let section: TableViewSection<BookmarkCellView> = TableViewSection(
                title: element.key == todayDate ? AppStrings.HistoryToday.localizedString() : element.key,
                viewModels: models
            )
            
            section.deleteAction = { indexPath in
                action(.delete(item: sortedItems[indexPath.row]))
            }
            
            return section
        })

        sections = sections.sorted{
            guard let s0 = $0.title?.toDate(), let s1 = $1.title?.toDate() else {
                return true
            }

            return s0 < s1

        }

    }
}

extension Date {
    func toString() -> String {
        let dateFormater = DateFormatter()
        dateFormater.timeStyle = .none
        dateFormater.dateStyle = .long
        
        return dateFormater.string(from: self)
    }
}

extension String {
    func toDate() -> Date? {
        let dateFormater = DateFormatter()
        dateFormater.timeStyle = .none
        dateFormater.dateStyle = .long

        return dateFormater.date(from: self)
    }
}
