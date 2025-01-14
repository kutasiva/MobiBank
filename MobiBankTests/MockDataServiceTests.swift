//
//  MockAccountServiceTests.swift
//  MobiBankTests
//
//  Created by kutasov on 29.12.2024.
//

@testable import MobiBank
import XCTest

@MainActor
class MockAccountServiceTests: XCTestCase {
    var mockAccountService: MockAccountService!
    var fixedDate: Date!
    var sender: AccountDetail!
    var receiver: AccountDetail!
    var amount: Amount!
    var transaction1: Transaction!
    var transaction2: Transaction!
    var mockAccounts: [Account]!

    override func setUpWithError() throws {
        fixedDate = Date(timeIntervalSince1970: 1609459200) // Fixed date for comparison

        sender = AccountDetail(
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

        receiver = AccountDetail(
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

        amount = Amount(
            value: 150.75,
            precision: 2,
            currency: "USD"
        )

        transaction1 = Transaction(
            amount: amount,
            type: "Credit",
            dueDate: fixedDate,
            processingDate: fixedDate,
            sender: sender,
            receiver: receiver,
            typeDescription: "Salary Payment"
        )

        transaction2 = Transaction(
            amount: amount,
            type: "Debit",
            dueDate: fixedDate,
            processingDate: fixedDate,
            sender: receiver,
            receiver: sender,
            typeDescription: "Invoice Payment"
        )

        let mockTransactions: [Transaction] = [transaction1, transaction2]

        mockAccounts = [
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
        ]

        mockAccountService = MockAccountService(accounts: mockAccounts, transactions: mockTransactions)
    }

    override func tearDownWithError() throws {
        mockAccountService = nil
        fixedDate = nil
        sender = nil
        receiver = nil
        amount = nil
        transaction1 = nil
        transaction2 = nil
        mockAccounts = nil
    }

    func testGetAccounts() async throws {
        // Given: Expected mock accounts
        let expectedAccounts = mockAccounts

        // When: Fetch accounts
        let accounts = try await mockAccountService.getAccounts()

        // Then: Assert the expected outcomes
        XCTAssertEqual(accounts.count, expectedAccounts?.count, "The number of accounts should match the mock data.")
        XCTAssertEqual(accounts, expectedAccounts, "The accounts should match the mock data.")
    }

    func testGetAccountTransactions() async throws {
        // Given: Expected mock transactions
        let expectedTransactions: [Transaction] = [transaction1, transaction2]

        // When: Fetch transactions for an account
        let transactions = try await mockAccountService.getAccountTransactions(for: "123456")

        // Then: Assert the expected outcomes
        XCTAssertEqual(transactions.count, expectedTransactions.count, "The number of transactions should match the mock data.")
        XCTAssertEqual(transactions, expectedTransactions, "The transactions should match the mock data.")
    }

    func testAsyncBehavior() async throws {
        // When: Measure the time taken to fetch accounts
        let start = Date()
        _ = try await mockAccountService.getAccounts()
        let end = Date()

        // Then: Assert that the delay is roughly 1 second
        let duration = end.timeIntervalSince(start)
        XCTAssert(duration >= 1.0, "The async delay should be at least 1 second.")
    }
}
