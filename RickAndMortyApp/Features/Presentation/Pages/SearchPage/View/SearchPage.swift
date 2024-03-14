//
//  SearchPage.swift
//  RickAndMortyApp
//
//  Created by Goncalves Higino on 14/03/24.
//

import SwiftUI
import Observation

struct SearchPage: View {
    
    @Bindable var viewModel: SearchPageViewModel
    @State var text = ""
    @State var showCharacterDetail = false
    @State var selectedCharacter: CharacterBusinessModel?
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.characterList.isEmpty {
                    emptyView
                } else {
                    searchView
                }
              Spacer()
            }
        }
        .searchable(text: $text)
        .onChange(of: text) { _, newValue in
            searchCharacter(by: newValue)
        }
    }
    
    var emptyView: some View {
        Text("No Found Result")
            .searchViewStyle()
    }
    
    var searchView: some View {
        ScrollView {
            scrollDetectionView
            characterListView
        }
        .searchViewStyle()
        .coordinateSpace(.named("scrollview"))
        .sheet(isPresented: $showCharacterDetail, content: {
            CharacterDetailPage(character: selectedCharacter)
        })
    }
    
    var scrollDetectionView: some View {
        GeometryReader { proxy in
            let offset = proxy.frame(in: .named("scrollview")).minY
            Color.clear.preference(key: ScrollPreferenceKey.self, value: offset)
        }
        .onPreferenceChange(ScrollPreferenceKey.self, perform: { value in
            withAnimation(.easeInOut) {
                let estimatedContentHeight = CGFloat(viewModel.characterList.count * 50)
                let threshold = 0.4 * estimatedContentHeight
                if value <= -threshold {
                    Task {
                        await viewModel.searchCharacter(by: text, isFirstLoad: false)
                    }
                }
            }
        })
    }
    
    var characterListView: some View {
        ForEach(Array(viewModel.characterList.enumerated()), id: \.offset) { index, character in
            if index != 0 {
                Divider()
            }
            
            Button {
                showCharacterDetail.toggle()
                selectedCharacter = character
            } label: {
                ListRowView(title: character.name, image: character.image)
                if viewModel.isLoading {
                    ProgressView()
                        .accentColor(.white)
                }
            }
        }
    }
}


extension SearchPage {
    func searchCharacter(by text: String) {
        viewModel.workiItem?.cancel()
        let task = DispatchWorkItem { [weak viewModel] in
            guard let viewModel else { return }
            Task {
                await viewModel.searchCharacter(by: text, isFirstLoad: true)
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: task)
        viewModel.workiItem =  task
    }
}
