//
//  HomeCoordinator.swift
//  DeFi Browser
//
//  Created by daniel.da.cunha.lima on 16/07/21.
//

import CoordinatorKit
import UIKit

final class HomeCoordinator: Coordinator {

    var rootViewController: UINavigationController
    var initialViewController: HomeViewController
    let service: DefiService
    let databaseService: DatabaseService

    init(databaseService: DatabaseService) {
        self.databaseService = databaseService
        self.service = DefiService()
        initialViewController = HomeViewController(service: service, databaseService: databaseService)
        rootViewController = UINavigationController(rootViewController: initialViewController)
        initialViewController.nextResponder = self
    }

}

extension HomeCoordinator: HomeActionProtocol {
    
    func handle(event: HomeAction) {
        switch event {
        case let .goToItem(defiItem):
            let coordinator = BrowserCoordinator(defiItem: defiItem, databaseService: databaseService)
            router(NavigationTransition.present(coordinator))
        case let .goToURL(url):
            let coordinator = BrowserCoordinator(url: url, databaseService: databaseService)
            router(NavigationTransition.present(coordinator))
        case let .searchText(text):
            let searchPath = "https://www.google.com/search?q=\(text)"
            if let encodedURL = searchPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
               let url = URL(string: encodedURL)
            {
                let coordinator = BrowserCoordinator(url: url, databaseService: databaseService)
                router(NavigationTransition.present(coordinator))
            }
        case let .delete(item):
            initialViewController.deleteBookmark(item: item)
        }
    }

}
