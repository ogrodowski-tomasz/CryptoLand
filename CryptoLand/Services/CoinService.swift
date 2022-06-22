//
//  CoinOverallService.swift
//  asyncCrypto
//
//  Created by Tomasz Ogrodowski on 22/06/2022.
//

import Foundation

enum CoinGeckoEndpoint: String {
    case markets
}

protocol CoinService  {
    func fetchCoins(from endpoint: CoinGeckoEndpoint) async throws -> [Coin]
}
