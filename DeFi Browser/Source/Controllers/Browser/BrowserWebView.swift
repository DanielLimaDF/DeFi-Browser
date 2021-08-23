//
//  BrowserWebView.swift
//  DeFi Browser
//
//  Created by Daniel Lima on 21/08/21.
//

import Foundation
import UIKit
import WebKit

protocol BrowserWebViewDelegate: AnyObject {
    func didLoad(html: String)
    func didFinish(navigation: WKNavigation, webView: WKWebView)
}

class BrowserWebView: WKWebView {
    
    weak var delegate: BrowserWebViewDelegate?
    
    init() {
        super.init(frame: .zero, configuration: WKWebViewConfiguration())
        navigationDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func extractHTML() {
        let query = "document.documentElement.outerHTML"
        
        evaluateJavaScript(query) { [weak self] (result, error) in
            guard let stringResult = result as? String else {
                return
            }
            self?.delegate?.didLoad(html: stringResult)
        }
    }
    
}

extension BrowserWebView: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        extractHTML()
        delegate?.didFinish(navigation: navigation, webView: webView)
    }
    
}
