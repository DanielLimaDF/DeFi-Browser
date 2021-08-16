//
//  DefiService.swift
//  DeFi Browser
//
//  Created by daniel.da.cunha.lima on 31/07/21.
//

import Foundation
import SimpleNetwork

class DefiService {

    private let service: SimpleNetwork

    init() {
        service = SimpleNetwork(networkSession: SimpleNetworkSession())
    }

    internal func defiList(completion: @escaping (Result<[DefiItem], NetworkError>) -> Void) {
        service.execute(request: DefiRouter.list, completion: completion)
    }

}
