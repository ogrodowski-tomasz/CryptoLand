//
//  PortfolioView.swift
//  asyncCrypto
//
//  Created by Tomasz Ogrodowski on 22/06/2022.
//

import SwiftUI

struct PortfolioView: View {
    @Environment(\.dismiss) var dismiss

    @EnvironmentObject private var viewModel: HomeViewModel
    @State private var selectedCoin: Coin? = nil
    @State private var quantityText: String = ""
    @State private var showCheckmark: Bool = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    coinLogoList

                    if selectedCoin != nil {
                        portfolioInputSection
                    }
                }
            }
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("x")
                            .font(.headline)
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    trailingNavButton
                }
            }
            .background(Color.indigo.ignoresSafeArea())

        }
    }

    private var coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(viewModel.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                updateSelectedCoin(coin: coin)
                            }
                        }
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coin.id ? Color.green : Color.clear, lineWidth: 1)
                        }
                }
            }
            .frame(height: 120)
            .padding(.leading)
        }
    }

    private func updateSelectedCoin(coin: Coin) {
        self.selectedCoin = coin

        if
            let portfolioCoin = viewModel.portfolioCoins.first(where: { $0.id == coin.id }),
            let amount = portfolioCoin.currentHoldings {
            quantityText = "\(amount)"
        } else {
            quantityText = ""
        }
    }

    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText.replacingOccurrences(of: ",", with: ".")) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }

    private var portfolioInputSection: some View {
        withAnimation(.none) {
            VStack(spacing: 20) {
                HStack {
                    Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                    Spacer()
                    Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
                }
                Divider()
                HStack {
                    Text("Amount holding:")
                    Spacer()
                    TextField("Ex. 1.4", text: $quantityText)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                }
                Divider()
                HStack {
                    Text("Current value:")
                    Spacer()
                    Text(getCurrentValue().asCurrencyWith2Decimals())
                }
            }
            .padding()
            .font(.headline)
        }
    }

    private var trailingNavButton: some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark")
                .opacity(showCheckmark ? 1.0 : 0.0)
            Button {
                saveButtonPressed()
            } label: {
                Text("Save".uppercased())
            }
            .opacity(
                (selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText.replacingOccurrences(of: ",", with: "."))) ? 1.0 : 0.0
            )
        }
        .font(.headline)
    }

    private func saveButtonPressed() {
        guard
            let coin = selectedCoin,
            let amount = Double(quantityText.replacingOccurrences(of: ",", with: "."))
        else { return }
        viewModel.updatePortfolio(coin: coin, amount: amount)
        withAnimation(.easeIn) {
            showCheckmark = true
            removeSelectedCoin()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeOut) {
                showCheckmark = false
            }
        }
    }

    private func removeSelectedCoin() {
        selectedCoin = nil
    }
}

struct PortfolioView_Previews: PreviewProvider {

    static var previews: some View {
        PortfolioView()
            .environmentObject(HomeViewModel())
    }
}
