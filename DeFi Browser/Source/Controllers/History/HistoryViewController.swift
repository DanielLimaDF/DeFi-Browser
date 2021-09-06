//
//  HistoryViewController.swift
//  DeFi Browser
//
//  Created by Daniel Lima on 16/07/21.
//

import Foundation
import UIKit

class HistoryViewController: UIViewController {

    let databaseService: DatabaseService
    var historyRegisters: [HistoryItemDao] {
        didSet {
            update()
        }
    }
    
    required init(databaseService: DatabaseService) {
        self.databaseService = databaseService
        self.historyRegisters = Array()
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadFromDatabase()
    }
    
    override func loadView() {
        let historyView = HistoryView()
        view = historyView
    }
    
    func setupNavigation() {
        title = AppStrings.TabbarHistory.localizedString()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = ColorPalette.accentColor
        appearance.titleTextAttributes = [.foregroundColor: ColorPalette.titleTextColor]
        appearance.largeTitleTextAttributes = [.foregroundColor: ColorPalette.titleTextColor]
        appearance.shadowColor = ColorPalette.accentColor
        
        navigationController?.navigationBar.tintColor = ColorPalette.buttonColor
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        let clearItem = UIBarButtonItem(image: IconLibrary.trash, style: .plain, target: self, action: #selector(clearHistory))
        
        navigationItem.setRightBarButton(clearItem, animated: true)
    }
    
    func loadFromDatabase() {
        historyRegisters = databaseService.getHistory()
    }
    
    func deleteHistory(historyItem: HistoryItemDao) {
        databaseService.removeHistory(item: historyItem)
        loadFromDatabase()
    }
    
    @objc func clearHistory() {
        
        perform(action: HistoryAction.showConfirmation(completion: { [weak self] in
            self?.databaseService.clearHistory()
            self?.loadFromDatabase()
        }))
        
    }
    
    private func update() {
        let model = HistoryViewModel(historyItems: historyRegisters) { [weak self] action in
            self?.perform(action: action)
        }
        (view as? HistoryView)?.viewModel = model
    }

}
