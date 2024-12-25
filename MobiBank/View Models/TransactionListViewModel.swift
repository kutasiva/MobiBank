//
//  s.swift
//  MobiBank
//
//  Created by kutasov on 25.12.2024.
//
import Foundation

@MainActor
@Observable final class TransactionListViewModel {
    private let dataService: DataServiceProtocol

    private(set) var accountTransactions = [TransactionViewModel]()
    private(set) var acountId: String

    private(set) var isLoading = false
    private(set) var errorMessage: String?

    init(acountId: String, dataService: DataServiceProtocol) {
        self.dataService = dataService
        self.acountId = acountId
    }

    func fetchAccountTransactions() async {
        isLoading = true
        errorMessage = nil
        do {
            let transactions = try await dataService.getAccountTransactions(for: acountId)
            accountTransactions = transactions.map { TransactionViewModel(transaction: $0) }
        } catch {
            errorMessage = "Error fetching account transactions: \(error.localizedDescription)"
            isLoading = false
        }
        isLoading = false
    }
}
