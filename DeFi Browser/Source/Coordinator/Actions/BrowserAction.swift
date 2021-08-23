//
//  BrowserAction.swift
//  DeFi Browser
//
//  Created by Daniel Lima on 21/08/21.
//

import Foundation
import CoordinatorKit

protocol BrowserActionProtocol {
    func handle(event: BrowserAction)
}

enum BrowserAction: Event {
    
    case dismiss
    
    func sendToHandler(_ handler: BrowserActionProtocol) {
        handler.handle(event: self)
    }
}
