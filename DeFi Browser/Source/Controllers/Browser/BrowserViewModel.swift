//
//  BrowserViewModel.swift
//  DeFi Browser
//
//  Created by Daniel Lima on 21/08/21.
//

import Foundation

protocol BrowserViewModelProtocol {
    var url: URL { get }
}

struct BrowserViewModel: BrowserViewModelProtocol {
    var url: URL
}
