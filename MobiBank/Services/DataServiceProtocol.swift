//
//  DataServiceProtocol.swift
//  MobiBank
//
//  Created by kutasov on 23.12.2024.
//

protocol DataServiceProtocol {
    func getAccounts() async throws -> [Account]
}
