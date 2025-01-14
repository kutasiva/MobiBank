//
//  NetworkError.swift
//  MobiBank
//
//  Created by kutasov on 23.12.2024.
//

enum NetworkServiceError: Error {
    case badServerResponse(statusCode: Int)
    case unauthorized
    case forbidden
    case notFound
    case internalServerError
    case unknownError

    var errorMessage: String {
        switch self {
        case .badServerResponse(let statusCode):
            return "Unexpected server response with status code: \(statusCode)."
        case .unauthorized:
            return "Unauthorized access. Please check your API key."
        case .forbidden:
            return "Access forbidden. You don't have permission to access this resource."
        case .notFound:
            return "Data not found. Please check the account ID."
        case .internalServerError:
            return "Internal server error. Please try again later."
        case .unknownError:
            return "An unknown error occurred."
        }
    }
}
