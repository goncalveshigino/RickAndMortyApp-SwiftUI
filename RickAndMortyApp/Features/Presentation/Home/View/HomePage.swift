//
//  HomePage.swift
//  RickAndMortyApp
//
//  Created by Goncalves Higino on 12/03/24.
//

import SwiftUI
import Observation

struct HomePage: View {
    
    @EnvironmentObject var router: Router
    @Bindable var viewModel: HomePageViewModel
    
    @State var showStatusBar = true
    @State var contentHasScrolled = false
    @State var showNav = false
    @State var showDetail: Bool = false
    @State var selectedCharacter: CharacterBusinessModel?
    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            scrollView
        }.onChange(of: showDetail) {
            withAnimation {
                showNav.toggle()
                showStatusBar.toggle()
            }
        }.overlay(NavigationBarView(title: "Character", contentHasScrolled: $contentHasScrolled))
    }
    
    var scrollView: some View {
        ScrollView() {
            
        }
    }
}

