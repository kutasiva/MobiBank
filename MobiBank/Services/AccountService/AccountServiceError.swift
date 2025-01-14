//
//  AccountServiceError.swift
//  MobiBank
//
//  Created by kutasov on 14.01.2025.
//

import Foundation

enum AccountServiceError: Error {
    case decodingError
    case invalidURL
    case networkError(NetworkServiceError)
    case unknownError
    
    var errorMessage: String {
        switch self {
        case .decodingError:
            return "Failed to decode the response data."
        case .invalidURL:
            return "Invalid URL. Please check the URL and try again."
        case .networkError(let networkError):
            return networkError.errorMessage
        case .unknownError:
            return "An unknown error occurred."
        }
    }
}
