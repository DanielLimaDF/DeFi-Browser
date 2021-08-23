//
//  BrowserView.swift
//  DeFi Browser
//
//  Created by Daniel Lima on 20/08/21.
//

import Foundation
import WebKit
import UIKit

class BrowserView: UIView {
    
    var viewModel: BrowserViewModelProtocol? {
        didSet {
            update()
        }
    }
    
    let webView: BrowserWebView
    let toolBar: UIToolbar
    
    init() {
        webView = BrowserWebView()
        toolBar = UIToolbar()
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update() {
        if let model = viewModel {
            webView.load(URLRequest(url: model.url))
        }
    }
    
    @objc func goBackwards() {
        webView.goBack()
    }
    
    @objc func goForward() {
        webView.goForward()
    }
    
    @objc func reload() {
        webView.reload()
    }
    
}

extension BrowserView: ViewCoding {

    func buildViewHierarchy() {
        addSubview(toolBar)
        addSubview(webView)
    }

    func setupConstraints() {
        toolBar.snp.makeConstraints { make in
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottomMargin)
        }
        
        webView.snp.makeConstraints { make in
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            make.top.equalTo(safeAreaLayoutGuide.snp.topMargin)
            make.bottom.equalTo(toolBar.snp.top)
        }
    }
    
    func configure() {
        let backwardToolbarItem = UIBarButtonItem(image: IconLibrary.chevronBackward, style: .plain, target: self, action: #selector(goBackwards))
        let fixedSpacingToolbarItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        let forwardToolbarItem = UIBarButtonItem(image: IconLibrary.chevronForward, style: .plain, target: self, action: #selector(goForward))
        let flexibleSpaceToolbarItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let reloadToolbarItem = UIBarButtonItem(image: IconLibrary.clockwiseArrow, style: .plain, target: self, action: #selector(reload))
        
        fixedSpacingToolbarItem.width = SizeToken.toolbarFixedSpacing
        
        toolBar.setItems([backwardToolbarItem, fixedSpacingToolbarItem, forwardToolbarItem, flexibleSpaceToolbarItem, reloadToolbarItem], animated: true)
    }

    func render() {
        backgroundColor = ColorPalette.accentColor
        toolBar.barTintColor = ColorPalette.accentColor
        toolBar.tintColor = ColorPalette.buttonColor
        webView.isOpaque = false
    }

}
