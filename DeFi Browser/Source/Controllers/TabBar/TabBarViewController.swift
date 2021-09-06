//
//  TabBarViewController.swift
//  DeFi Browser
//
//  Created by Daniel Lima on 16/07/21.
//

import UIKit

class TabBarViewController: UITabBarController {

    required init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        tabBar.barTintColor = ColorPalette.interactionColor
        tabBar.tintColor = ColorPalette.buttonColor
        tabBar.isTranslucent = true
    }

}
