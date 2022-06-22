//
//  CoinStore.swift
//  asyncCrypto
//
//  Created by Tomasz Ogrodowski on 22/06/2022.
//

import Foundation

class CoinStore: CoinService {
    static let shared = CoinStore()
    private init() { }

    func fetchCoins(from endpoint: CoinGeckoEndpoint) async throws -> [Coin] {
        guard let url = URL(string: "\(Constans.baseAPIURL)\(endpoint.rawValue)") else {
            throw APIRequestError.invalidEndpoint
        }
        let coins: [Coin] = try await NetworkingManager.shared.loadURLAndDecode(url: url, params: Constans.basicMarketParams)
        return coins
    }

}
