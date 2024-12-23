//
//  DataService.swift
//  MobiBank
//
//  Created by kutasov on 23.12.2024.
//
import Foundation

actor DataSerivce: DataServiceProtocol {
    private let url = URL(string: "https://webapi.developers.erstegroup.com/api/csas/public/sandbox/v3/transparentAccounts")!
    private let apiKey = "492e8b9e-7c57-4ddd-8ba9-ea0f8475c3a2"

    func getAccounts() async throws -> [Account] {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "WEB-API-key")

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200
        else {
            throw NetworkError.badServerResponse
        }
        // Print the raw response data
        if let jsonString = String(data: data, encoding: .utf8) {
            print("Response JSON String: \(jsonString)")
        } else {
            print("Failed to convert data to String")
        }
        guard let accountResponse = try? JSONDecoder().decode(AccountResponse.self, from: data) else {
            throw NetworkError.decodingError
        }

        return accountResponse.accounts
    }
}
