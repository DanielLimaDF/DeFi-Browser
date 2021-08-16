//
//  HistoryCoordinator.swift
//  DeFi Browser
//
//  Created by daniel.da.cunha.lima on 16/07/21.
//

import CoordinatorKit
import UIKit

final class HistoryCoordinator: Coordinator {

    var rootViewController: UINavigationController

    init() {
        rootViewController = UINavigationController(rootViewController: HistoryViewController())
    }

}
