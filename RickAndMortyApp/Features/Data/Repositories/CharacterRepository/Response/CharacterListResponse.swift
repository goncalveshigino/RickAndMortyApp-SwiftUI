//
//  CharacterListResponse.swift
//  RickAndMortyApp
//
//  Created by Goncalves Higino on 10/03/24.
//

import Foundation

// MARK: - APIResponse
struct CharacterListResponse: Codable {
    let info: InfoResponse
    let results: [CharacterResponse]
}

// MARK: - Info
struct InfoResponse: Codable {
    let count, pages: Int
    let next, prev: String?
}

// MARK: - Result
struct CharacterResponse: Codable {
    let id: Int
    let name: String
    let status: StatusResponse
    //let species: SpeciesResponse
    let species, type: String
    let gender: GenderResponse
    let origin, location: LocationResponse
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

enum GenderResponse: String, Codable {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
}

// MARK: - Location
struct LocationResponse: Codable {
    let name: String
    let url: String
}

//enum SpeciesResponse: String, Codable {
//    case alien = "Alien"
//    case human = "Human"
//}

enum StatusResponse: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}




