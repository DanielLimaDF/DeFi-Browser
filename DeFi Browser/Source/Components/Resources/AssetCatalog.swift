//
//  AssetCatalog.swift
//  DeFi Browser
//
//  Created by Daniel Lima on 30/07/21.
//

import Foundation
import UIKit

enum AssetCatalog {
    static let progress = Asset(name: "progress")
    static let counterclockwiseArrow = UIImage(systemName: "arrow.counterclockwise.circle.fill")
}

struct Asset {
    var name: String

    var image: UIImage {
        guard let imageAsset = UIImage(named: name) else {
            fatalError("Unable to load image named \(name)")
        }
        return imageAsset
    }
}
