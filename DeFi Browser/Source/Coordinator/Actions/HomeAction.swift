//
//  HomeAction.swift
//  DeFi Browser
//
//  Created by Daniel Lima on 19/08/21.
//

import Foundation
import CoordinatorKit

protocol HomeActionProtocol {
    func handle(event: HomeAction)
}

enum HomeAction: Event, Equatable {
    
    case goToItem(defiItem: DefiItem)
    case goToURL(url: URL)
    case searchText(text: String)
    case delete(item: DefiItem)
    
    func sendToHandler(_ handler: HomeActionProtocol) {
        handler.handle(event: self)
    }
}
