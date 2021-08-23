//
//  HistorytemDao.swift
//  DeFi Browser
//
//  Created by Daniel Lima on 22/08/21.
//

import Foundation
import RealmSwift

class HistoryItemDao: Object {
    @Persisted var date: Date
    @Persisted var title: String
    @Persisted var descriptionText: String
    @Persisted var iconURL: String
    @Persisted var url: String
    
    convenience init(item: DefiItem) {
        self.init()
        date = Date()
        title = item.title
        descriptionText = item.description
        iconURL = item.iconURL
        url = item.url
    }
    
    func item() -> DefiItem {
        return DefiItem(title: title, description: descriptionText, iconURL: iconURL, url: url)
    }
}
