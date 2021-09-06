//
//  CellViewModel.swift
//  DeFi Browser
//
//  Created by Daniel Lima on 17/07/21.
//

import Foundation
import UIKit

protocol CellViewModelPrototol {
    var title: String { get }
    var subtitle: String { get }
    var iconURL: String { get }
    var didAction: (() -> Void)? { get }
}

struct CellViewModel: CellViewModelPrototol {
    var title: String
    var subtitle: String
    var iconURL: String
    var didAction: (() -> Void)?
}
