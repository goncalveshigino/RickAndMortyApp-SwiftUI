//
//  AppError.swift
//  RickAndMortyApp
//
//  Created by Goncalves Higino on 10/03/24.
//

import Foundation

enum AppError: Error {
    case serviceError(error: Error)
    case invalidUrl
    case missingData
    case unExpectedError
    case parseError
}

extension AppError {
    var errorDescription: String? {
        switch self {
        case .serviceError(let error):
            return NSLocalizedString("\(error.localizedDescription)", comment: "Service error")
        case .invalidUrl:
            return NSLocalizedString("APP-ERROR", comment: "Invalid url error")
        case .missingData:
            return NSLocalizedString("APP-ERROR", comment: "misssing data error")
        case .unExpectedError:
            return NSLocalizedString("APP-ERROR", comment: "Erro inesperado tente mais tarde")
        case .parseError:
            return NSLocalizedString("APP-ERROR", comment: "Parse error")
        }
    }
}
