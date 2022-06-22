//
//  Constans.swift
//  iHaveNothingToWatch
//
//  Created by Tomasz Ogrodowski on 21/06/2022.
//

import Foundation

struct Constans {
    static let apiKey = "5dc7e54902c614c9e74d8afc6499e284"
    static let baseAPIURL = "https://api.coingecko.com/api/v3/coins/"
    static let basicMarketParams: [String : String] = [
        "vs_currency" : "usd",
        "order" : "market_cap_desc",
        "per_page" : "250",
        "page" : "1",
        "sparkline" : "true",
        "price_change_percentage" : "24h"
    ]
    
    static let basicCoinParams: [String : String] = [
        "localization" : "false",
        "tickers" : "false",
        "market_data" : "false",
        "community_data" : "false",
        "developer_data" : "false",
        "sparkline" : "false"
    ]
}


// LINKS
// Overall: https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h

// Detail: https://api.coingecko.com/api/v3/coins/bitcoin?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false


