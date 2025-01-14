//
//  Untitled.swift
//  MobiBank
//
//  Created by kutasov on 23.12.2024.
//
import Foundation

@Observable final class AccountListViewModel {
    let accountService: AccountServiceProtocol
    @MainActor private(set) var viewState: ViewState<[AccountViewModel]> = .idle

    init(accountService: AccountServiceProtocol) {
        self.accountService = accountService
    }

    func fetchAccounts() async {
        await setViewState(.loading)
        do {
            let accounts = try await accountService.getAccounts()
            let accountViewModels = accounts.map { AccountViewModel(account: $0) }
            await setViewState(.loaded(accountViewModels))
        } catch {
            await setViewState(.error("Failed to load accounts: \(error.localizedDescription)"))
        }
    }

    @MainActor
    private func setViewState(_ state: ViewState<[AccountViewModel]>) {
        viewState = state
    }
}
