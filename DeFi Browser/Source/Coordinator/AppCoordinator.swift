//
//  AppCoordinator.swift
//  DeFi Browser
//
//  Created by daniel.da.cunha.lima on 20/06/21.
//

import CoordinatorKit
import UIKit
import RealmSwift

final class AppCoordinator: Coordinator {

    var rootViewController: UITabBarController
    let databaseService: DatabaseService

    init() {
        
        let realmConfig = Realm.Configuration(
            schemaVersion: 1,
            shouldCompactOnLaunch: { totalBytes, usedBytes in
                return (Double(usedBytes) / Double(totalBytes)) < 0.5
            }
        )
        
        databaseService = DatabaseService(config: realmConfig)
        rootViewController = TabBarViewController()
        start()
    }

    private func start(){
        router(TabBarTransition.set(createCoordinators()))
    }

    private func createCoordinators() -> [Presentable] {
        let homeCoordinator = HomeCoordinator(databaseService: databaseService)
        let historyCoordinator = HistoryCoordinator(databaseService: databaseService)

        homeCoordinator.viewController.tabBarItem = UITabBarItem(
            title: AppStrings.TabbarDefi.localizedString(),
            image: IconLibrary.squareGrid,
            tag: 0
        )
        historyCoordinator.viewController.tabBarItem = UITabBarItem(
            title: AppStrings.TabbarHistory.localizedString(),
            image: IconLibrary.clock,
            tag: 1
        )

        return [homeCoordinator, historyCoordinator]
    }

}
