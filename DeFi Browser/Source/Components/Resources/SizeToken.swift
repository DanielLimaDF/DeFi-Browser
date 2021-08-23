//
//  SizeToken.swift
//  DeFi Browser
//
//  Created by daniel.da.cunha.lima on 11/07/21.
//

import Foundation
import UIKit

enum SizeToken {
    static let margingExtraSmall = 4
    static let margingSmall = 8
    static let margingMedium = 16
    static let serchbarHeight = 76
    static let toolbarFixedSpacing = CGFloat(50)
    static var collectionCellSize: CGFloat {
        let totalLineSpacing = CGFloat(SizeToken.margingSmall) * 3
        let totalMarging = CGFloat(SizeToken.margingMedium) * 2
        let squareSize = ((UIScreen.main.bounds.width - totalMarging - totalLineSpacing) / 4)
        return squareSize
    }
}
