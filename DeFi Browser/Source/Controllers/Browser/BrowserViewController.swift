//
//  BrowserViewController.swift
//  DeFi Browser
//
//  Created by Daniel Lima on 19/08/21.
//

import Foundation
import UIKit
import WebKit

class BrowserViewController: UIViewController, StatefulProtocol {
    
    let databaseService: DatabaseService
    var bookmarkItem: UIBarButtonItem?
    let parser: BrowserHTMLParser
    var defiItem: DefiItem?
    var url: URL?
    
    init(defiItem: DefiItem, parser: BrowserHTMLParser, databaseService: DatabaseService) {
        self.databaseService = databaseService
        self.defiItem = defiItem
        self.parser = parser
        super.init(nibName: nil, bundle: nil)
    }
    
    init(url: URL, parser: BrowserHTMLParser, databaseService: DatabaseService) {
        self.databaseService = databaseService
        self.url = url
        self.parser = parser
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        beginStateWithTimer(delay: 14)
    }
    
    override func loadView() {
        let browserView = BrowserView()
        var model: BrowserViewModel?
        
        if let item = defiItem, let defiURL = URL(string: item.url) {
            model = BrowserViewModel(url: defiURL)
        } else if let defiURL = url {
            model = BrowserViewModel(url: defiURL)
        }
        
        browserView.viewModel = model
        browserView.webView.delegate = self
        view = browserView
    }
    
    func setupNavigation() {
        navigationController?.navigationBar.barTintColor = ColorPalette.accentColor
        
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(close))
        bookmarkItem = UIBarButtonItem(image: IconLibrary.star, style: .plain, target: self, action: #selector(toggleBookmark))
        
        doneItem.tintColor = ColorPalette.buttonColor
        bookmarkItem?.tintColor = ColorPalette.buttonColor
        
        navigationItem.setLeftBarButton(doneItem, animated: true)
        navigationItem.setRightBarButton(bookmarkItem, animated: true)
    }
    
    func handleBookmarkStatus() {
        guard let item = defiItem else {
            return
        }
        
        let isBookmarked = databaseService.isBookmarked(item: item)
        bookmarkItem?.image = isBookmarked ? IconLibrary.starFill : IconLibrary.star
    }
    
    func addHistoryRegister() {
        guard let item = defiItem else {
            return
        }
        
        databaseService.addHistory(item: item)
    }
    
    @objc func close() {
        perform(action: BrowserAction.dismiss)
    }
    
    @objc func toggleBookmark() {
        if let item = defiItem {
            databaseService.toggleBookmark(item: item)
            handleBookmarkStatus()
        }
    }

}

extension BrowserViewController: BrowserWebViewDelegate {
    
    func didLoad(html: String) {
        
        guard let currentUrl = (view as? BrowserView)?.webView.url else {
            return
        }
        
        parser.parse(html: html, url: currentUrl) { [weak self] result in
            switch result {
            case let .success(value):
                self?.title = value.title
                self?.defiItem = value
                self?.handleBookmarkStatus()
                self?.addHistoryRegister()
            case .failure:
                self?.defiItem = nil
            }
        }
    }
    
    func didFinish(navigation: WKNavigation, webView: WKWebView) {
        endState()
        handleBookmarkStatus()
    }
    
}
