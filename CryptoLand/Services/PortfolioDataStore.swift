//
//  PortfolioDataStore.swift
//  asyncCrypto
//
//  Created by Tomasz Ogrodowski on 22/06/2022.
//

import CoreData
import Foundation

class PortfolioCoreData: PortfolioService {

    static let shared = PortfolioCoreData()

    private let container: NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "PortfolioEntity"

    @Published var savedEntities: [PortfolioEntity] = []

    private init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _ , error in
            if let error = error {
                print("error loading coredata: \(error)")
            }
            self.getPortfolio()
        }
    }


    func updatePortfolio(coin: Coin, amount: Double) {
        if let entity = savedEntities.first(where: { $0.coinID == coin.id }) {
            if amount > 0 {
                updateCoin(entity: entity, amount: amount)
            } else {
                delete(entity: entity)
            }
        } else {
            addCoin(coin: coin, amount: amount)
        }
    }

    func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch {
            print("Error fetching portfolio entities: \(error)")
        }
    }

    func addCoin(coin: Coin, amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChanges()
    }

    func save() {
        do {
            try container.viewContext.save()
        } catch {
            print("Error saving data: \(error)")
        }
    }

    func delete(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }

    func applyChanges() {
        save()
        getPortfolio()
    }

    func updateCoin(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChanges()
    }


}
