//
//  Coin+Stub.swift
//  asyncCrypto
//
//  Created by Tomasz Ogrodowski on 22/06/2022.
//

import Foundation

extension Coin {
    static var stubbedCoins: [Coin] {
        let reposnse: [Coin]? = try? Bundle.main.loadAndDecodeJSON(filename: "coin_list")
        return reposnse!
    }
    static var stubbedCoin: Coin {
        stubbedCoins[0]
    }
}
