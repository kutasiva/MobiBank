//
//  DataServiceProtocol.swift
//  MobiBank
//
//  Created by kutasov on 23.12.2024.
//

import Foundation

protocol AccountServiceProtocol {
    func getAccounts() async throws -> [Account]
    func getAccountTransactions(for accountId: String) async throws -> [Transaction]
}
