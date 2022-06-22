//
//  CoinDetail+Stub.swift
//  asyncCrypto
//
//  Created by Tomasz Ogrodowski on 22/06/2022.
//

import Foundation

extension CoinDetail {
    static var stubbedCoinDetails: CoinDetail {
        let response: CoinDetail? = try? Bundle.main.loadAndDecodeJSON(filename: "coin_detail")
        return response!
    }
}
