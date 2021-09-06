//
//  DefiService.swift
//  DeFi Browser
//
//  Created by Daniel Lima on 31/07/21.
//

import Foundation
import SimpleNetwork

protocol DefiServiceProtocol {
    func defiList(completion: @escaping (Result<[DefiItem], NetworkError>) -> Void)
}

class DefiService: DefiServiceProtocol {

    private let service: SimpleNetwork

    init() {
        service = SimpleNetwork(networkSession: SimpleNetworkSession())
    }

    func defiList(completion: @escaping (Result<[DefiItem], NetworkError>) -> Void) {
        service.execute(request: DefiRouter.list, completion: completion)
    }

}
