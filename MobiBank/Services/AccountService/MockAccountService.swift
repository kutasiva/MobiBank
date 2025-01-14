//
//  MockAccountService.swift
//  MobiBank
//
//  Created by kutasov on 23.12.2024.
//

import Foundation

actor MockAccountService: AccountServiceProtocol {
    let mockAccounts: [Account]
    let mockTransactions: [Transaction]

    init(accounts: [Account]? = nil, transactions: [Transaction]? = nil) {
        mockAccounts = accounts ?? MockAccountService.loadMockData(filename: "mockAccounts.json")
        mockTransactions = transactions ?? MockAccountService.loadMockData(filename: "mockTransactions.json")
    }

    func getAccounts() async throws -> [Account] {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second
        return mockAccounts
    }

    func getAccountTransactions(for accountId: String) async throws -> [Transaction] {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second
        return mockTransactions
    }

    private static func loadMockData<T: Decodable>(filename: String) -> T {
        guard let url = Bundle.main.url(forResource: filename, withExtension: nil) else {
            fatalError("Failed to locate \(filename) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(filename) from bundle.")
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        guard let loadedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(filename) from bundle.")
        }

        return loadedData
    }
}
