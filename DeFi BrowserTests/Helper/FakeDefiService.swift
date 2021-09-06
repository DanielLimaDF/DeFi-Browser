//
//  FakeDefiService.swift
//  DeFi BrowserTests
//
//  Created by Daniel Lima on 04/09/21.
//

import Foundation
import SimpleNetwork

@testable import DeFi_Browser

class FakeDefiService: DefiServiceProtocol {
    
    func defiList(completion: @escaping (Result<[DefiItem], NetworkError>) -> Void) {
        
        let decoder = JSONDecoder()
        var json = String()
        var items: [DefiItem] = []
        let file = Bundle(for: object_getClass(self)!).path(forResource: "DeFiList", ofType: "json")
        do {
            json = try String(contentsOfFile: file!, encoding: .utf8)
            items = try decoder.decode([DefiItem].self, from: json.data(using: .utf8)!)
        } catch {
            completion(.failure(NetworkError.parseFailed))
            return
        }
        
        completion(.success(items))
    }
    
}
