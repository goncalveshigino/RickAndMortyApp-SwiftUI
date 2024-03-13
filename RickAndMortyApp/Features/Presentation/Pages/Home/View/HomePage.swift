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
        }
        .overlay(NavigationBarView(title: "Character", contentHasScrolled: $contentHasScrolled))
        .statusBar(hidden: !showStatusBar)
        .onAppear {
            Task {
                await viewModel.loadCharacterList()
            }
        }
        .alert(isPresented: $viewModel.hasError) {
            
            Alert(
                title: Text("Importante Message"),
                message: Text(viewModel.viewError?.localizedDescription ?? "UnexPected error in happen"),
                dismissButton: .default(Text("Go it!"))
            )
            
        }
        .sheet(isPresented: $showDetail) {
            //CharacterDetailView(character: selectedCharacter)
        }
        .preferredColorScheme(.dark)
    }
    
    var scrollView: some View {
        ScrollView() {
            scrollDetectionView
            characterListView
                .padding(.vertical, 70)
                .padding(.bottom, 50)
        }.coordinateSpace(.named("scroll"))
    }
    
    var scrollDetectionView: some View {
        GeometryReader { proxy in
            let offset = proxy.frame(in: .named("scroll")).minY
            Color.clear.preference(key: ScrollPreferenceKey.self, value: offset)
        }
        .onPreferenceChange(ScrollPreferenceKey.self) { value in
            withAnimation(.easeInOut) {
                let estimatedContentHeight = CGFloat(viewModel.characterList.count * 100)
                let threshold = 0.8 * estimatedContentHeight
                if value <= -threshold {
                    Task {
                        await viewModel.loadCharacterList()
                    }
                }
                contentHasScrolled = value < 0 // ? true : false
    
            }
        }
    }
    
    var characterListView: some View {
        VStack(spacing: 16) {
            ForEach(Array(viewModel.characterList.enumerated()), id: \.offset) { index, businessModel in
                SectionRowView(section: SectionRowModel(businessModel: businessModel))
                    .onTapGesture {
                        selectedCharacter =  businessModel
                        showDetail = true
                    }
                if index == viewModel.characterList.count - 1 {
                    Divider()
                    if viewModel.isLoading {
                        ProgressView("Loading more characters...")
                            .accentColor(.white)
                    }
                } else {
                    Divider()
                }
            }
        }
        .padding(20)
        .background(.ultraThinMaterial)
        .backgroundStyle(cornerRadius: 30)
        .padding(.horizontal, 20)
    }
}

