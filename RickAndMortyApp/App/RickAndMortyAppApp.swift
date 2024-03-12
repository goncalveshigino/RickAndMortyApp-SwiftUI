//
//  RickAndMortyAppApp.swift
//  RickAndMortyApp
//
//  Created by Goncalves Higino on 10/03/24.
//

import SwiftUI

@main
struct RickAndMortyAppApp: App {
    @StateObject var router = Router()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navStack) {
                ContentView()
            }.environmentObject(router)
        }
    }
}
