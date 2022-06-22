//
//  CoinRowView.swift
//  asyncCrypto
//
//  Created by Tomasz Ogrodowski on 22/06/2022.
//

import SwiftUI

struct CoinRowView: View {

    let coin: Coin
    let showHoldingsColumns: Bool

    var body: some View {
        HStack(spacing: 0) {
            leftColumn
            Spacer()
            if showHoldingsColumns {
                centerColumn
            }
            rightColumn
        }
        .font(.subheadline)
        .background(Color.indigo.opacity(0.001))
    }

    private var leftColumn: some View {
        HStack(spacing: 0) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(.white)
                .frame(minWidth: 30)
            CoinImageView(imageURL: coin.imageURL)
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundColor(.white)
        }
    }

    private var centerColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                .bold()
            Text((coin.currentHoldings ?? 0).asNumberString())
        }
        .foregroundColor(.white)
    }

    private var rightColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice.asCurrencyWith6Decimals())
                .bold()
                .foregroundColor(.white)
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .foregroundColor(
                    (coin.priceChangePercentage24H ?? 0) >= 0
                    ? Color.green
                    : Color.red
                )
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinRowView(coin: Coin.stubbedCoin, showHoldingsColumns: false)
                .previewLayout(.sizeThatFits)

            CoinRowView(coin: Coin.stubbedCoin, showHoldingsColumns: true)
                .previewLayout(.sizeThatFits)
        }
        .background(Color.indigo)
    }
}
