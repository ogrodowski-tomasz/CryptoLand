//
//  HomeViewModel.swift
//  asyncCrypto
//
//  Created by Tomasz Ogrodowski on 22/06/2022.
//

import Foundation

@MainActor
final class HomeViewModel: ObservableObject {

    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []

    let coinService: CoinService
    let portfolioService: PortfolioService

    init(coinService: CoinService = CoinStore.shared, portfolioSevice: PortfolioService = PortfolioCoreData.shared) {
        self.coinService = coinService
        self.portfolioService = portfolioSevice
    }

    func updatePortfolio(coin: Coin, amount: Double) {
        portfolioService.updatePortfolio(coin: coin, amount: amount)
        fetchPortfolioCoinData()
    }

    func fetchPortfolioCoinData() {
        self.portfolioCoins = allCoins.compactMap({ coin -> Coin? in
            guard let entity = portfolioService.savedEntities.first(where: { $0.coinID == coin.id }) else {
                return nil
            }
            return coin.updateHoldings(amount: entity.amount)
        })
    }

    func fetchCoinDataFromEndpoint(_ endpoint: CoinGeckoEndpoint) async {
        do {
            self.allCoins = try await coinService.fetchCoins(from: endpoint)
            fetchPortfolioCoinData()
        } catch {
            print(error)
        }
    }
}
