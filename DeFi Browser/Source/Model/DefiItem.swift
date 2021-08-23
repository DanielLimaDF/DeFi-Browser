//
//  DefiItem.swift
//  DeFi Browser
//
//  Created by daniel.da.cunha.lima on 17/07/21.
//

import Foundation
import UIKit

struct DefiItem: Codable {
    var title: String
    var description: String
    var iconURL: String
    var url: String
    
    func baseURL() -> String {
        var components = URLComponents(string: url)
        components?.query = nil
        return components?.url?.absoluteString ?? String()
    }
    
    func cleanBaseURL() -> String {
        var baseURL = baseURL()
        baseURL = baseURL.replacingOccurrences(of: "http://", with: "")
        baseURL = baseURL.replacingOccurrences(of: "https://", with: "")
        if baseURL.last == "/" {
            baseURL = String(baseURL.dropLast())
        }
        return baseURL
    }
}
