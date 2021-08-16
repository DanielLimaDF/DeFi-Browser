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
    let service: DefiService

    init() {
        service = DefiService()
        rootViewController = UINavigationController(rootViewController: HomeViewController(service: service))
    }

}
