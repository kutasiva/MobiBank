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
    var mockDataService: MockDataService!

    override func setUpWithError() throws {
        mockDataService = MockDataService()
        viewModel = AccountListViewModel(dataService: mockDataService)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockDataService = nil
    }

    func testFetchAccountsSuccess() async throws {
        // Given
        mockDataService.mockAccounts = [
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
            )
        ]
      
        // When
        await viewModel.fetchAccounts()
        
        // Then
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.accounts.count, 1)
        XCTAssertEqual(viewModel.accounts.first?.accountNumber, "000000-0109213309")
    }
}
