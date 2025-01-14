//
//  NetworkService.swift
//  MobiBank
//
//  Created by kutasov on 14.01.2025.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchData(from url: URL) async throws -> Data
}

class NetworkService: NetworkServiceProtocol {
    private let apiKey = "492e8b9e-7c57-4ddd-8ba9-ea0f8475c3a2"

    func fetchData(from url: URL) async throws -> Data {
        let request = createRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkServiceError.unknownError
        }

        switch httpResponse.statusCode {
        case 200:
            return data
        case 400:
            throw NetworkServiceError.badServerResponse(statusCode: 400)
        case 401:
            throw NetworkServiceError.unauthorized
        case 403:
            throw NetworkServiceError.forbidden
        case 404:
            throw NetworkServiceError.notFound
        case 500:
            throw NetworkServiceError.internalServerError
        default:
            throw NetworkServiceError.badServerResponse(statusCode: httpResponse.statusCode)
        }
    }

    private func createRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "WEB-API-key")
        return request
    }
}
