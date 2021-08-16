//
//  HomeViewController.swift
//  DeFi Browser
//
//  Created by daniel.da.cunha.lima on 20/06/21.
//

import UIKit
import SwiftUI

class HomeViewController: UIViewController, StatefulProtocol {

    let service: DefiService

    required init(service: DefiService) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let homeView = HomeView()
        view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        loadData()
    }

    func setupNavigation() {
        navigationController?.isNavigationBarHidden = true
    }

    private func loadData() {
        beginState()

        service.defiList { [weak self] result in
            switch result {
            case let .success(values):
                let model = HomeViewModel(deFiItems: values)
                (self?.view as? HomeView)?.viewModel = model
                self?.endState()
            case .failure:
                self?.endStateWithError()
            }
        }
    }

}
