//
//  ContentView.swift
//  RickAndMortyApp
//
//  Created by Goncalves Higino on 10/03/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var model = NavigationBarModel()
    
    var body: some View {
        HomePage(viewModel: HomePageViewModel())
            .environmentObject(model)
    }
}

#Preview {
    ContentView()
}
