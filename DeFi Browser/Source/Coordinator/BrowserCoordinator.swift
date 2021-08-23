//
//  BrowserCoordinator.swift
//  DeFi Browser
//
//  Created by Daniel Lima on 19/08/21.
//

import CoordinatorKit
import UIKit

final class BrowserCoordinator: Coordinator {

    var rootViewController: UINavigationController

    init(defiItem: DefiItem, parser: BrowserHTMLParser = BrowserHTMLParser(), databaseService: DatabaseService) {
        let controller = BrowserViewController(defiItem: defiItem, parser: parser, databaseService: databaseService)
        rootViewController = UINavigationController(rootViewController: controller)
        controller.nextResponder = self
        setup()
    }
    
    init(url: URL, parser: BrowserHTMLParser = BrowserHTMLParser(), databaseService: DatabaseService) {
        let controller = BrowserViewController(url: url, parser: parser, databaseService: databaseService)
        rootViewController = UINavigationController(rootViewController: controller)
        controller.nextResponder = self
        setup()
    }
    
    func setup() {
        rootViewController.modalPresentationStyle = .fullScreen
        rootViewController.modalTransitionStyle = .flipHorizontal
    }
    
}

extension BrowserCoordinator: BrowserActionProtocol {
    func handle(event: BrowserAction) {
        switch event {
        case .dismiss:
            router(NavigationTransition.dismiss())
        }
    }
}
