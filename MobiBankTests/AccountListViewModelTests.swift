//
//  AccountListViewModelTests.swift
//  MobiBankTests
//
//  Created by kutasov on 25.12.2024.
//

@testable import MobiBank
import XCTest

@MainActor
class AccountListViewModelTests: XCTestCase {
    var viewModel: AccountListViewModel!
    var mockAccountService: MockAccountService!

    override func setUpWithError() throws {
        mockAccountService = MockAccountService(accounts: [Account(
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
        )])
        viewModel = AccountListViewModel(accountService: mockAccountService)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockAccountService = nil
    }

    func testFetchAccountsSuccess() async throws {
        // Given

        // When
        await viewModel.fetchAccounts()

        // Then
        switch viewModel.viewState {
            case .loading:
                XCTFail("Expected viewState to not be loading")
            case .error(let message):
                XCTFail("Expected viewState to not be error, but got: \(message)")
            case .loaded(let accounts):
                XCTAssertEqual(accounts.count, 1)
                XCTAssertEqual(accounts.first?.account.accountNumber, "000000-0109213309")
            case .idle:
                XCTFail("Expected viewState to be set, but it was nil")
        }
    }
}
