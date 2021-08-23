//
//  DAppCellViewModel.swift
//  DeFi Browser
//
//  Created by daniel.da.cunha.lima on 17/07/21.
//

import Foundation

protocol DAppCellViewModelProtocol {
    var models: [CellViewModelPrototol] { get }
}

struct DAppCellViewModel: DAppCellViewModelProtocol {
    var models: [CellViewModelPrototol]
}
