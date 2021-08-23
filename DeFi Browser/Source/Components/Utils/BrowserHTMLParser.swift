//
//  BrowserHTMLParser.swift
//  DeFi Browser
//
//  Created by Daniel Lima on 20/08/21.
//

import Foundation
import SimpleNetwork
import SwiftSoup
import UIKit

class BrowserHTMLParser {

    func parse(html: String, url: URL, completion: @escaping (Result<DefiItem, NetworkError>) -> Void) {
        
        do {
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
            urlComponents?.query = nil
            
            let doc = try SwiftSoup.parse(html)
            var baseURL = urlComponents?.url
            
            if let urlToEvaluate = baseURL, !urlToEvaluate.lastPathComponent.isEmpty, urlToEvaluate.lastPathComponent != "/" {
                baseURL = urlToEvaluate.deletingLastPathComponent()
            }
            
            let headerTitle = try doc.title()
            let textualDescription = try doc.getMetaProperty(propertyName: "description")
            var iconURL = String()
            
            if let baseIconURL = baseURL {
                iconURL = try doc.getIcon(baseURL: baseIconURL)
            }
            
            let defiItem = DefiItem(
                title: headerTitle,
                description: textualDescription,
                iconURL: iconURL,
                url: url.absoluteString
            )
            
            completion(.success(defiItem))
            
        } catch {
            completion(.failure(NetworkError.parseFailed))
        }
        
    }

}

extension Document {

    func getMetaProperty(propertyName: String) throws -> String {
        let meta: Element? = try head()?.select("meta[name='\(propertyName)']").first()
        let content: String? = try meta?.attr("content")
        return content ?? String()
    }

    func getIcon(baseURL: URL) throws -> String {
        let links = try getElementsByAttributeValue("rel", "apple-touch-icon")
        var standardizedURL = baseURL

        if standardizedURL.absoluteString.last == "/", let dropedURL = URL(string: String(standardizedURL.absoluteString.dropLast())) {
            standardizedURL = dropedURL
        }

        guard links.count > 0 else {
            if let icon = try select("meta[property=og:image]").first() {
                return try icon.attr("content")
            } else {
                return String()
            }
        }

        let sortedLinks = try links.sorted(by: {
            let first = try $0.attr("sizes").sizeIntValue()
            let last = try $1.attr("sizes").sizeIntValue()
            return first < last
        })

        if let lastLink = sortedLinks.last {
            var icon = try lastLink.attr("href")
            
            if let url = URL(string: icon), UIApplication.shared.canOpenURL(url) {
                return icon
            } else {
                icon = icon.replacingOccurrences(of: "../", with: String())
                icon = icon.replacingOccurrences(of: "./", with: String())
                icon = standardizedURL.appendingPathComponent(icon).absoluteString
                return icon
            }
            
        } else {
            return String()
        }
    }

}

private extension String {
    func sizeIntValue() -> Int {
        let stringValues = split(separator: "x")
        if let stringValue = stringValues.first, let intValue = Int(stringValue) {
            return intValue
        } else {
            return 0
        }
    }
}
