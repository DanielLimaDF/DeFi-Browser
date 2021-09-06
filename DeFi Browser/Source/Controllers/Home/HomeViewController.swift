//
//  HomeViewController.swift
//  DeFi Browser
//
//  Created by Daniel Lima on 20/06/21.
//

import UIKit

class HomeViewController: UIViewController, StatefulProtocol {

    let service: DefiServiceProtocol
    let databaseService: DatabaseService
    
    var dApps: [DefiItem] {
        didSet {
            update()
        }
    }
    
    var bookmarks: [DefiItem] {
        didSet {
            update()
        }
    }

    required init(service: DefiServiceProtocol, databaseService: DatabaseService) {
        dApps = Array()
        bookmarks = Array()
        self.service = service
        self.databaseService = databaseService
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let homeView = HomeView()
        homeView.delegate = self
        view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadFromDatabase()
    }

    func setupNavigation() {
        navigationController?.isNavigationBarHidden = true
    }

    private func loadData() {
        beginState()

        service.defiList { [weak self] result in
            switch result {
            case let .success(values):
                self?.dApps = values
                self?.endState()
            case .failure:
                self?.endStateWithError()
            }
        }
    }
    
    func loadFromDatabase() {
        bookmarks = databaseService.getBookmarks()
    }
    
    func deleteBookmark(item: DefiItem) {
        databaseService.removeBookmark(item: item)
        loadFromDatabase()
    }
    
    private func update() {
        let model = HomeViewModel(deFiItems: dApps, bookmarkItems: bookmarks) { [weak self] action in
            self?.perform(action: action)
        }
        (view as? HomeView)?.viewModel = model
    }

}

extension HomeViewController: HomeViewDelegate {
    
    func didSelectURL(url: URL) {
        perform(action: HomeAction.goToURL(url: url))
    }
    
    func didSelectSearch(text: String) {
        perform(action: HomeAction.searchText(text: text))
    }
    
}
