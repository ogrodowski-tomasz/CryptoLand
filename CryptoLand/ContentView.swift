//
//  ContentView.swift
//  asyncCrypto
//
//  Created by Tomasz Ogrodowski on 21/06/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var homeVM = HomeViewModel()
    var body: some View {
        NavigationView {
            HomeView()
                .navigationBarHidden(true)
        }
        .environmentObject(homeVM)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
