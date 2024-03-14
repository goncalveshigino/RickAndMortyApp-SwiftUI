//
//  SearchPageViewModel.swift
//  RickAndMortyApp
//
//  Created by Goncalves Higino on 13/03/24.
//

import Foundation
import Observation

@Observable class SearchPageViewModel {
    private var useCase: CharacterUseCase
    private var currentPage: Int = 1
    private var canFetchMoreCharacters: Bool = true
    
    var isLoading: Bool = false
    var characterList: [CharacterBusinessModel] = []
    var workiItem: DispatchWorkItem?
    
    init(useCase: CharacterUseCase = DefaultCharacterUseCase()) {
        self.useCase = useCase
    }
    
    func searchCharacter(by name: String, isFirstLoad: Bool) async {
        if name.isEmpty {
            resetSearch()
            return
        }
        guard !isLoading, canFetchMoreCharacters else { return }
        isLoading = true
        if isFirstLoad {
            currentPage = 1
            characterList = []
        }
        
        await fetchSearchCharacter(by: name)
    }
}


extension SearchPageViewModel {
    
    private func fetchSearchCharacter(by name: String) async {
        do {
            let response = try await useCase.searchCharacter(by: name, and: "\(currentPage)")
            await MainActor.run {
                characterList += response.results
                currentPage += 1
                isLoading = false
                canFetchMoreCharacters = true
            }
        } catch {
            await handleError()
        }
    }
    
    private func resetSearch() {
        canFetchMoreCharacters = true
        characterList = []
        currentPage = 1
    }
    
    private func handleError() async {
        if characterList.isEmpty {
            await MainActor.run {
                isLoading = false
            }
        } else {
            await MainActor.run {
                isLoading = false
                canFetchMoreCharacters = false
            }
        }
    }
}
