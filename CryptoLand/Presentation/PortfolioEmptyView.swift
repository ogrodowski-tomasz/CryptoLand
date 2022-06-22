//
//  PortfolioEmptyView.swift
//  asyncCrypto
//
//  Created by Tomasz Ogrodowski on 22/06/2022.
//

import SwiftUI

struct PortfolioEmptyView: View {
    var body: some View {
        Text("You haven't added any coins to Your portfolio yet! Click '+' button to get started!!")
            .font(.callout)
            .foregroundColor(Color.white)
            .fontWeight(.medium)
            .multilineTextAlignment(.center)
            .padding(50)
    }
}

struct PortfolioEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioEmptyView()
    }
}
