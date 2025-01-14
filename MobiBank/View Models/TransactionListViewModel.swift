//
//  s.swift
//  MobiBank
//
//  Created by kutasov on 25.12.2024.
//
import Foundation

@Observable final class TransactionListViewModel {
    private let accountService: AccountServiceProtocol
    @MainActor private(set) var viewState: ViewState<[TransactionViewModel]> = .idle
    private(set) var accountId: String

    init(accountId: String, accountService: AccountServiceProtocol) {
        self.accountService = accountService
        self.accountId = accountId
    }

    func fetchAccountTransactions() async {
        await setViewState(.loading)
        do {
            let transactions = try await accountService.getAccountTransactions(for: accountId)
            let transactionViewModels = transactions.map { TransactionViewModel(transaction: $0) }
            await setViewState(.loaded(transactionViewModels))
        } catch {
            await setViewState(.error("Error fetching account transactions: \(error.localizedDescription)"))
        }
    }

    @MainActor
    private func setViewState(_ state: ViewState<[TransactionViewModel]>) {
        viewState = state
    }
}
