//
//  StatefulProtocol.swift
//  DeFi Browser
//
//  Created by daniel.da.cunha.lima on 30/07/21.
//

import Foundation
import PKHUD

protocol StatefulProtocol {
    func beginState()
    func endState()
    func endStateWithError()
}

extension StatefulProtocol {

    func beginState() {
        HUD.show(.rotatingImage(AssetCatalog.progress.image))
    }

    func endState() {
        HUD.hide()
    }

    func endStateWithError() {
        HUD.show(.error)
        HUD.hide(afterDelay: 2.0)
    }

}
