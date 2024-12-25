//
//  DataService.swift
//  MobiBank
//
//  Created by kutasov on 23.12.2024.
//
import Foundation

actor DataService: DataServiceProtocol {
    private let baseURL = "https://webapi.developers.erstegroup.com/api/csas/public/sandbox/v3/transparentAccounts"
    private let apiKey = "492e8b9e-7c57-4ddd-8ba9-ea0f8475c3a2"

    private var accountsURL: URL {
        URL(string: baseURL)!
    }

    private func transactionsURL(for accountId: String) -> URL {
        URL(string: "\(baseURL)/\(accountId)/transactions")!
    }

    private func createRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "WEB-API-key")
        return request
    }

    private func logResponse(_ data: Data) {
        if let jsonString = String(data: data, encoding: .utf8) {
            print("Response JSON String: \(jsonString)")
        } else {
            print("Failed to convert data to String")
        }
    }

    private func fetchData<T: Decodable>(from url: URL, decodingType: T.Type) async throws -> T {
        let request = createRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw DataServiceError.badServerResponse
        }

        logResponse(data)

        do {
            // Decode the JSON response to the specified type
            return try JSONDecoder.withCustomDateDecoding.decode(decodingType, from: data)
        } catch {
            throw DataServiceError.decodingError
        }
    }

    func getAccounts() async throws -> [Account] {
        let accountResponse: AccountResponse = try await fetchData(from: accountsURL, decodingType: AccountResponse.self)
        return accountResponse.accounts
    }

    func getAccountTransactions(for accountId: String) async throws -> [Transaction] {
        let transactionURL = transactionsURL(for: accountId)
        let accountTransactionsResponse: AccountTransactionsResponse = try await fetchData(from: transactionURL, decodingType: AccountTransactionsResponse.self)
        return accountTransactionsResponse.transactions
    }
}
