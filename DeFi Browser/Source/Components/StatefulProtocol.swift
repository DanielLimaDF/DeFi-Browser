//
//  StatefulProtocol.swift
//  DeFi Browser
//
//  Created by Daniel Lima on 30/07/21.
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
    
    func beginStateWithTimer(delay: TimeInterval) {
        HUD.flash(.rotatingImage(AssetCatalog.progress.image), delay: delay)
    }

    func endState() {
        HUD.hide()
    }

    func endStateWithError() {
        HUD.show(.error)
        HUD.hide(afterDelay: 2.0)
    }

}
