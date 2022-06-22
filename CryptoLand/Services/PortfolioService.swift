//
//  PortfolioService.swift
//  asyncCrypto
//
//  Created by Tomasz Ogrodowski on 22/06/2022.
//

import Foundation
import CoreData

protocol PortfolioService {
    var savedEntities: [PortfolioEntity] { get }
    func updatePortfolio(coin: Coin, amount: Double)
    func getPortfolio()

    func addCoin(coin: Coin, amount: Double)
    func updateCoin(entity: PortfolioEntity, amount: Double)
    func save()
    func delete(entity: PortfolioEntity)
    func applyChanges()
}
