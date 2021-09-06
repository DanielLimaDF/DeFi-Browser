//
//  SizeToken.swift
//  DeFi Browser
//
//  Created by Daniel Lima on 11/07/21.
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
        var totalLineSpacing = CGFloat(SizeToken.margingSmall) * 3
        let totalMarging = CGFloat(SizeToken.margingMedium) * 2
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            let squareSize = ((UIScreen.main.bounds.width - totalMarging - totalLineSpacing) / 4)
            return squareSize
        } else {
            totalLineSpacing = CGFloat(SizeToken.margingSmall) * 7
            let squareSize = ((1024 - totalMarging - totalLineSpacing) / 8)
            return squareSize
        }
        
    }
}
