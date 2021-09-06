//
//  FakeCoordinator.swift
//  DeFi BrowserTests
//
//  Created by Daniel Lima on 02/09/21.
//

import CoordinatorKit
import UIKit

@testable import DeFi_Browser

internal class FakeCoordinator<T: Event>: Coordinator {
    var lastAction: T?
    var lastHistoryItem: DefiItem?
    var rootViewController: UINavigationController
    
    init(controller: UIViewController) {
        rootViewController = UINavigationController(rootViewController: controller)
        controller.beginAppearanceTransition(true, animated: false)
        controller.endAppearanceTransition()
        controller.nextResponder = self
    }
}

extension FakeCoordinator: BrowserActionProtocol, HomeActionProtocol, HistoryActionActionProtocol {
    
    func handle(event: BrowserAction) {
        storeAction(event: event)
    }
    
    func handle(event: HomeAction) {
        storeAction(event: event)
    }
    
    func handle(event: HistoryAction) {
        storeAction(event: event)
        
        switch event {
        case let .goToItem(defiItem):
            lastHistoryItem = defiItem
        default:
            return
        }
    }
    
    private func storeAction<E: Event>(event: E) {
        guard let castedEvent = event as? T else {
            return
        }
        
        lastAction = castedEvent
    }
    
}
