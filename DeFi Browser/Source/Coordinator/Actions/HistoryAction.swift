//
//  HistoryAction.swift
//  DeFi Browser
//
//  Created by Daniel Lima on 23/08/21.
//

import Foundation
import CoordinatorKit

protocol HistoryActionActionProtocol {
    func handle(event: HistoryAction)
}

enum HistoryAction: Event {
    
    case goToItem(defiItem: DefiItem)
    case showConfirmation(completion: (() -> Void))
    case delete(item: HistoryItemDao)
    
    func sendToHandler(_ handler: HistoryActionActionProtocol) {
        handler.handle(event: self)
    }
}
