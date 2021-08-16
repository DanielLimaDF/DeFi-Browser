//
//  DefiRouter.swift
//  DeFi Browser
//
//  Created by daniel.da.cunha.lima on 31/07/21.
//

import Foundation
import SimpleNetwork

enum DefiRouter: Requestable {

    case list

    var method: HTTPMethod {
        switch  self {
        case .list:
            return .get
        }
    }

    var path: String {
        switch self {
        case .list:
            return "https://gist.githubusercontent.com/DanielLimaDF/4f2b319d04ff99950fed9eb4d554d91c/raw/8e36131e13e0dc6117d75c10d917f09918153c85/DeFiList.json"
        }
    }

    var parameters: Parameters? {
        return nil
    }

    func urlRequest() throws -> URLRequest {
        if let url = URL(string: path) {
            return URLRequest(url: url)
        } else {
            throw NetworkError.invalidURL
        }
    }

}
