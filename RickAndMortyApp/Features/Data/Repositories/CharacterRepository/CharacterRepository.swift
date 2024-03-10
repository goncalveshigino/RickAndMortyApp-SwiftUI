//
//  CharacterRepository.swift
//  RickAndMortyApp
//
//  Created by Goncalves Higino on 10/03/24.
//

import Foundation

protocol CharacterRepository {
    func getCharacterList(pageNumber: String?) async throws -> CharacterListResponse
}


class DefaultCharacterRepository: CharacterRepository {
    
    private let apiService: ApiService
    
    init(apiService: ApiService = DefaultApiService()) {
        self.apiService = apiService
    }
    
    func getCharacterList(pageNumber: String?) async throws -> CharacterListResponse {
        do {
            let endpoint = RemoteURL.baseUrl + RemoteURL.characterUrl + "\(RemoteURL.pagination)\(pageNumber ?? "1")"
            let response: CharacterListResponse = try await apiService.getDataFromGetRequest(from: endpoint)
            return response
        } catch  {
            throw error
        }
    }
}
