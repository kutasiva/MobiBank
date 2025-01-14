//
//  DataService.swift
//  MobiBank
//
//  Created by kutasov on 23.12.2024.
//
import Foundation

actor AccountService: AccountServiceProtocol {
    private let baseURL = "https://webapi.developers.erstegroup.com/api/csas/public/sandbox/v3/transparentAccounts"
    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    private var accountsURL: URL? {
        URL(string: baseURL)
    }

    func getAccounts() async throws -> [Account] {
        guard let accountsURL = accountsURL else {
            throw AccountServiceError.invalidURL
        }
        do {
            let data = try await networkService.fetchData(from: accountsURL)
            logResponse(data)
            let accountResponse: AccountResponse = try decodeData(data, as: AccountResponse.self)
            return accountResponse.accounts
        } catch let error as NetworkServiceError {
            throw AccountServiceError.networkError(error)
        } catch {
            throw AccountServiceError.unknownError
        }
    }

    func getAccountTransactions(for accountId: String) async throws -> [Transaction] {
        guard let transactionURL = transactionsURL(for: accountId) else {
            throw AccountServiceError.invalidURL
        }
        do {
            let data = try await networkService.fetchData(from: transactionURL)
            logResponse(data)
            let accountTransactionsResponse: AccountTransactionsResponse = try decodeData(data, as: AccountTransactionsResponse.self)
            return accountTransactionsResponse.transactions
        } catch let error as NetworkServiceError {
            throw AccountServiceError.networkError(error)
        } catch {
            throw AccountServiceError.unknownError
        }
    }

    private func transactionsURL(for accountId: String) -> URL? {
        URL(string: "\(baseURL)/\(accountId)/transactions")
    }

    private func logResponse(_ data: Data) {
        #if DEBUG
        if let jsonString = String(data: data, encoding: .utf8) {
            print("Response JSON String: \(jsonString)")
        } else {
            print("Failed to convert data to String")
        }
        #endif
    }

    private func decodeData<T: Decodable>(_ data: Data, as type: T.Type) throws -> T {
        do {
            return try JSONDecoder.withCustomDateDecoding.decode(T.self, from: data)
        } catch {
            throw AccountServiceError.decodingError
        }
    }
}
