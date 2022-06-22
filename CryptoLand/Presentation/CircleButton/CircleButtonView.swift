//
//  CircleButtonView.swift
//  iCrypto
//
//  Created by Tomasz Ogrodowski on 17/04/2022.
//

import SwiftUI

struct CircleButtonView: View {

    let iconName: String

    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundColor(Color.white)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .fill(Color.yellow)

            )
            .shadow(
                color: Color.white.opacity(0.25),
                radius: 10, x: 0, y: 0)
            .padding()
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CircleButtonView(iconName: "info")
                .previewLayout(.sizeThatFits)

            CircleButtonView(iconName: "plus")
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
