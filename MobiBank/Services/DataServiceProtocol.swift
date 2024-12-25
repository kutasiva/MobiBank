//
//  DataServiceProtocol.swift
//  MobiBank
//
//  Created by kutasov on 23.12.2024.
//

import Foundation

protocol DataServiceProtocol {
    func getAccounts() async throws -> [Account]
    func getAccountTransactions(for acountId: String) async throws -> [Transaction]
}
