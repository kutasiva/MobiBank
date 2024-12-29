//
//  MockDataService.swift
//  MobiBank
//
//  Created by kutasov on 23.12.2024.
//

import Foundation

actor MockDataService: DataServiceProtocol {
    let mockAccounts: [Account]
    let mockTransactions: [Transaction]
    
    init(
        accounts: [Account] = [
            Account(
                accountNumber: "000000-0109213309",
                bankCode: "0800",
                transparencyFrom: "2015-01-24T00:00:00",
                transparencyTo: "3000-01-01T00:00:00",
                publicationTo: "3000-01-01T00:00:00",
                actualizationDate: "2018-01-17T13:00:00",
                balance: 165939.97,
                currency: "CZK",
                name: "Společenství Praha 4, Obětí 6.května 553",
                iban: "CZ75 0800 0000 0001 0921 3309"
            ),
            Account(
                accountNumber: "000000-0460043319",
                bankCode: "0800",
                transparencyFrom: "2015-04-08T00:00:00",
                transparencyTo: "3000-01-01T00:00:00",
                publicationTo: "3000-01-01T00:00:00",
                actualizationDate: "2018-01-17T13:00:18",
                balance: 899886.56,
                currency: "CZK",
                name: "Obec Nová Ves",
                iban: "CZ63 0800 0000 0004 6004 3319"
            )
        ],
        transactions: [Transaction] = {
            let sender = AccountDetail(
                accountNumber: "1234567890",
                bankCode: "9876",
                iban: "DE89370400440532013000",
                specificSymbol: "123",
                specificSymbolParty: "456",
                constantSymbol: "789",
                variableSymbol: "012",
                name: "John Doe",
                description: "Personal Account"
            )
            
            let receiver = AccountDetail(
                accountNumber: "0987654321",
                bankCode: "6789",
                iban: "FR7630006000011234567890189",
                specificSymbol: "321",
                specificSymbolParty: "654",
                constantSymbol: "987",
                variableSymbol: "210",
                name: "Jane Smith",
                description: "Business Account"
            )
            
            let amount = Amount(
                value: 150.75,
                precision: 2,
                currency: "USD"
            )
            
            let transaction1 = Transaction(
                amount: amount,
                type: "Credit",
                dueDate: Date(),
                processingDate: Date(),
                sender: sender,
                receiver: receiver,
                typeDescription: "Salary Payment"
            )
            
            let transaction2 = Transaction(
                amount: amount,
                type: "Debit",
                dueDate: Date(),
                processingDate: Date(),
                sender: receiver,
                receiver: sender,
                typeDescription: "Invoice Payment"
            )
            
            return [transaction1, transaction2]
        }()
    ) {
        mockAccounts = accounts
        mockTransactions = transactions
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
}
