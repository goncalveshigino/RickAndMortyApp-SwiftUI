//
//  HomePageViewModel.swift
//  RickAndMortyApp
//
//  Created by Goncalves Higino on 12/03/24.
//

import Foundation
import Observation


@Observable class HomePageViewModel {
    
    private let useCase: CharacterUseCase
    
    var characterList: [CharacterBusinessModel] = []
    
    var viewError: AppError?
    var hasError: Bool = false
    var isLoading: Bool = false
    private var currentPage: Int = 1
    
    
    init(useCase: CharacterUseCase = DefaultCharacterUseCase()) {
        self.useCase = useCase
    }
    
    func loadCharacterList() async {
        guard !isLoading else { return }
        
        isLoading = true
        
        do {
           let response = try await useCase.getCharacterList(pageName: "\(currentPage)")
            
            await MainActor.run {
                characterList += response.results // Append new characters to existing array
                hasError = false
                currentPage += 1
                isLoading = false
            }
        } catch {
            await MainActor.run {
                isLoading = false
                viewError = .unExpectedError
                hasError = true
            }
        }
    }
}
