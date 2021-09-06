//
//  HistoryCoordinator.swift
//  DeFi Browser
//
//  Created by Daniel Lima on 16/07/21.
//

import CoordinatorKit
import UIKit

final class HistoryCoordinator: Coordinator {

    var rootViewController: UINavigationController
    var initialViewController: HistoryViewController
    let databaseService: DatabaseService

    init(databaseService: DatabaseService) {
        self.databaseService = databaseService
        initialViewController = HistoryViewController(databaseService: databaseService)
        rootViewController = UINavigationController(rootViewController: initialViewController)
        initialViewController.nextResponder = self
    }

}

extension HistoryCoordinator: HistoryActionActionProtocol {
    
    func handle(event: HistoryAction) {
        switch event {
        case let .goToItem(defiItem):
            let coordinator = BrowserCoordinator(defiItem: defiItem, databaseService: databaseService)
            router(NavigationTransition.present(coordinator))
        case let .showConfirmation(completion):
            
            let confirmationAlert = UIAlertController(
                title: AppStrings.HistoryClearTitle.localizedString(),
                message: AppStrings.HistoryClearMessage.localizedString(),
                preferredStyle: UIAlertController.Style.alert
            )
            
            confirmationAlert.addAction(UIAlertAction(title: AppStrings.HistoryClearConfirmButton.localizedString(), style: .destructive) { _ in
                completion()
            })
            confirmationAlert.addAction(UIAlertAction(title: AppStrings.HistoryClearCancelButton.localizedString(), style: .cancel, handler: nil))
            
            router(NavigationTransition.present(confirmationAlert))
        case let .delete(item):
            initialViewController.deleteHistory(historyItem: item)
        }
    }

}
