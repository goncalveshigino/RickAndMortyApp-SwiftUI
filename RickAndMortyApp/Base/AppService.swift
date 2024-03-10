//
//  AppService.swift
//  RickAndMortyApp
//
//  Created by Goncalves Higino on 10/03/24.
//

import Foundation

protocol ApiService {
    func getDataFromGetRequest<Response: Codable>(from url: String) async throws -> Response
}

class DefaultApiService: ApiService {
    
    func getDataFromGetRequest<Response: Codable>(from url: String) async throws -> Response {
        guard let url = URL(string: url) else {
            throw AppError.invalidUrl
        }
        
        do {
          let (data,_) =  try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(Response.self, from: data)
        } catch {
            // If decoding fails, throw a perse error
            if (error as? DecodingError) != nil {
                throw AppError.parseError
            }
            //Else throw the original service error
            throw AppError.serviceError(error: error)
        }
    }
}
