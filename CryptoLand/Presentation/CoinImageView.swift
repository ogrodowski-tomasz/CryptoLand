//
//  CoinImageView.swift
//  asyncCrypto
//
//  Created by Tomasz Ogrodowski on 22/06/2022.
//

import SwiftUI

struct CoinImageView: View {

    let imageURL: URL

    @StateObject private var imageLoader = ImageLoader()

    var body: some View {
        ZStack {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .shadow(color: .white, radius: 4)
            } else {
                Image(systemName: "questionmark")
                    .foregroundColor(.gray)
            }
        }
        .task {
             await imageLoader.loadImage(with: imageURL)
        }
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(imageURL: Coin.stubbedCoin.imageURL)
    }
}
