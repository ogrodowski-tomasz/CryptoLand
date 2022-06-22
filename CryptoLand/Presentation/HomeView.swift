//
//  HomeView.swift
//  asyncCrypto
//
//  Created by Tomasz Ogrodowski on 22/06/2022.
//

import SwiftUI

struct HomeView: View {

    @EnvironmentObject private var viewModel: HomeViewModel

    @State private var showPortfolio: Bool = false
    @State private var showPortfolioView: Bool = false // new sheet

    @State private var selectedCoin: Coin? = nil
    @State private var showDetailView: Bool = false

    var body: some View {
        ZStack {
            Color.indigo
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView) {
                    PortfolioView()
                        .environmentObject(viewModel)
                }
            VStack {
                homeHeaderView
                if !showPortfolio {
                    coinList(coins: viewModel.allCoins, showHoldingsColumn: false)
                        .transition(.move(edge: .trailing))
                } else {
                    ZStack(alignment: .top) {
                        if viewModel.portfolioCoins.isEmpty {
                            PortfolioEmptyView()
                        } else {
                            coinList(coins: viewModel.portfolioCoins, showHoldingsColumn: true)
                        }
                    }
                    .transition(.move(edge: .leading))
                }
                Spacer(minLength: 0)
            }
        }
        .foregroundColor(.white)
        .task {
            await viewModel.fetchCoinDataFromEndpoint(.markets)
        }
    }

    private var homeHeaderView: some View {
        HStack {
            withAnimation(.none) {
                CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                    .onTapGesture {
                        if showPortfolio {
                            showPortfolioView = true
                        }
                    }
                    .background { CircleButtonAnimationView(animate: $showPortfolio) }
            }
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(.white)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }

    private func coinList(coins: [Coin], showHoldingsColumn: Bool) -> some View {
        List {
            ForEach(coins, id: \.id) { coin in
                CoinRowView(coin: coin, showHoldingsColumns: showHoldingsColumn)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .listRowBackground(Color.indigo)
            }
            .onDelete(perform: showPortfolio ? removeRows : nil)
        }
        .listStyle(.plain)
    }

    private func segue(coin: Coin) {
        selectedCoin = coin
        showDetailView.toggle()
    }

    private func removeRows(at offsets: IndexSet) {
//        viewModel.portfolioCoins.remove(atOffsets: offsets)
        offsets.forEach { index in
            let coin = viewModel.portfolioCoins[index]
            viewModel.updatePortfolio(coin: coin, amount: 0.0)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    
    static var previews: some View {
        HomeView()

    }
}
