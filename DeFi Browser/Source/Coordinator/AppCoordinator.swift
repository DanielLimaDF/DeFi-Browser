//
//  AppCoordinator.swift
//  DeFi Browser
//
//  Created by daniel.da.cunha.lima on 20/06/21.
//

import CoordinatorKit
import UIKit

final class AppCoordinator: Coordinator {

    var rootViewController: UITabBarController

    init() {
        rootViewController = TabBarViewController()
        start()
    }

    private func start(){
        router(TabBarTransition.set(createCoordinators()))
    }

    private func createCoordinators() -> [Presentable] {
        let homeCoordinator = HomeCoordinator()
        let historyCoordinator = HistoryCoordinator()

        homeCoordinator.viewController.tabBarItem = UITabBarItem(title: "DeFi", image: IconLibrary.squareGrid, tag: 0)
        historyCoordinator.viewController.tabBarItem = UITabBarItem(title: "History", image: IconLibrary.counterclockwiseArrow, tag: 1)

        return [homeCoordinator, historyCoordinator]
    }

}
