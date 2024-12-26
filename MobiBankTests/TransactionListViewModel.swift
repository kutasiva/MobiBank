//
//  TransactionListViewModel.swift
//  MobiBank
//
//  Created by kutasov on 25.12.2024.
//

@testable import MobiBank
import XCTest

@MainActor
class AccountTransactionsViewModelTests: XCTestCase {
    var viewModel: TransactionListViewModel!
    var mockDataService: MockDataService!

    override func setUpWithError() throws {
        mockDataService = MockDataService()
        viewModel = TransactionListViewModel(acountId: "123456", dataService: mockDataService)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockDataService = nil
    }

    func testFetchAccountTransactionsSuccess() async throws {
        // Given: Mock data is already set in MockDataService

        // When: Perform the action being tested
        await viewModel.fetchAccountTransactions()

        // Then: Assert the expected outcomes
        XCTAssertFalse(viewModel.isLoading, "View model should not be loading after fetching transactions.")
        XCTAssertNil(viewModel.errorMessage, "Error message should be nil after successful fetch.")
        XCTAssertEqual(viewModel.accountTransactions.count, 2, "There should be exactly two transactions.")
        XCTAssertEqual(viewModel.accountTransactions.first?.typeDescription, "Salary Payment", "The first transaction description should match the mock data.")
        XCTAssertEqual(viewModel.accountTransactions.last?.typeDescription, "Invoice Payment", "The second transaction description should match the mock data.")
    }

    // Add more tests for failure scenarios and other edge cases
}
