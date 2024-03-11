//
//  CharacterUseCase.swift
//  RickAndMortyApp
//
//  Created by Goncalves Higino on 11/03/24.
//

import Foundation

protocol CharacterUseCase {
    func getCharacterList(pageName: String?) async throws -> CharacterListBusinessModel
    func searchCharacter(by name: String, and pageNumber: String?) async throws -> CharacterListBusinessModel
}


class DefaultCharacterUseCase: CharacterUseCase {
    private let repository: CharacterRepository
    
    init(repository: CharacterRepository = DefaultCharacterRepository()) {
        self.repository = repository
    }
    
    func getCharacterList(pageName: String?) async throws -> CharacterListBusinessModel {
        do {
            let response = try await repository.getCharacterList(pageNumber: pageName)
            return CharacterListBusinessModel(response: response)
        } catch {
            throw error
        }
    }
    
    func searchCharacter(by name: String, and pageNumber: String?) async throws -> CharacterListBusinessModel {
        do {
            let response = try await repository.searchCharacter(by: name, and: pageNumber)
            return CharacterListBusinessModel(response: response)
        } catch {
            throw error
        }
    }
}
