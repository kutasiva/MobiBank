//
//  NetworkError.swift
//  MobiBank
//
//  Created by kutasov on 23.12.2024.
//

import Foundation

enum DataServiceError: Error {
    case badServerResponse
    case decodingError
    case unknown
}

extension DataServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .badServerResponse:
            return NSLocalizedString("Bad server response", comment: "")

        case .decodingError:
            return NSLocalizedString("Decoding error", comment: "")

        case .unknown:
            return NSLocalizedString("Unknown error", comment: "")
        }
    }
}
