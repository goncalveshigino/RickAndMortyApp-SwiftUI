//
//  CharacterRepository.swift
//  RickAndMortyApp
//
//  Created by Goncalves Higino on 10/03/24.
//

import Foundation

protocol CharacterRepository {
    func getCharacterList(pageNumber: String?) async throws -> CharacterListResponse
    func searchCharacter(by name: String, and pageNumber: String?) async throws -> CharacterListResponse
}


class DefaultCharacterRepository: CharacterRepository {
    
    private let apiService: ApiService
    private let cache = DefaultNSCacheStoreDatasource<String, CharacterListResponse>()
    
    init(apiService: ApiService = DefaultApiService()) {
        self.apiService = apiService
    }
    
    func getCharacterList(pageNumber: String?) async throws -> CharacterListResponse {
        if let cacheResponse = retreive(by: pageNumber ?? "1") {
            return cacheResponse
        }
        
        do {
            let endpoint = RemoteURL.baseUrl + RemoteURL.characterUrl + "\(RemoteURL.pagination)\(pageNumber ?? "1")"
            let response: CharacterListResponse = try await apiService.getDataFromGetRequest(from: endpoint)
            
            self.save(with: pageNumber ?? "1", response: response)
            return response
        } catch  {
            throw error
        }
    }
    
    func searchCharacter(by name: String, and pageNumber: String?) async throws -> CharacterListResponse {
        do {
            return try await apiService.getDataFromGetRequest(from: getEndPointForPagination(by: name, and: pageNumber))
        } catch {
            throw error
        }
    }
}

extension DefaultCharacterRepository {
    private func retreive(by pageNumber: String) -> CharacterListResponse? {
        //cache.retrieve(forKey: pageNumber)
        cache[pageNumber]
    }
    
    private func save(with pageNumber: String, response: CharacterListResponse) {
        cache[pageNumber] = response
    }
}

extension DefaultCharacterRepository {
    private func getEndPointForPagination(by name: String, and pageNumber: String?) -> String {
        if let pageNumber = pageNumber {
            return RemoteURL.baseUrl + RemoteURL.characterUrl + "\(RemoteURL.name)\(name)" + "\(RemoteURL.searchPagination)\(pageNumber)"
        } else {
            return RemoteURL.baseUrl + RemoteURL.characterUrl + "\(RemoteURL.name)\(name)"
        }
    }
}
