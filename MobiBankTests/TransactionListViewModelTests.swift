//
//  TransactionListViewModel.swift
//  MobiBank
//
//  Created by kutasov on 25.12.2024.
//

@testable import MobiBank
import XCTest

@MainActor
class TransactionListViewModelTests: XCTestCase {
    var viewModel: TransactionListViewModel!
    var mockAccountService: MockAccountService!

    override func setUpWithError() throws {
        mockAccountService = MockAccountService()
        viewModel = TransactionListViewModel(accountId: "123456", accountService: mockAccountService)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockAccountService = nil
    }

    func testFetchAccountTransactionsSuccess() async throws {
        // Given: Mock data is already set in MockDataService

        // When: Perform the action being tested
        await viewModel.fetchAccountTransactions()

        // Then
        switch viewModel.viewState {
        case .loading:
            XCTFail("Expected viewState to not be loading")
        case .error(let message):
            XCTFail("Expected viewState to not be error, but got: \(message)")
        case .loaded(let transactions):
            XCTAssertEqual(transactions.count, 2, "There should be exactly two transactions.")
            XCTAssertEqual(transactions.first?.typeDescription, "Salary Payment", "The first transaction description should match the mock data.")
            XCTAssertEqual(transactions.last?.typeDescription, "Invoice Payment", "The second transaction description should match the mock data.")
        case .idle:
            XCTFail("Expected viewState to be set, but it was nil")
        }
    }
}
