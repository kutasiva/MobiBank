//
//  Untitled.swift
//  MobiBank
//
//  Created by kutasov on 23.12.2024.
//
import Foundation

@MainActor
@Observable final class AccountListViewModel {
    let dataService: DataServiceProtocol

    private(set) var accounts = [AccountViewModel]()
    private(set) var isLoading = false
    private(set) var errorMessage: String?

    init(dataService: DataServiceProtocol) {
        self.dataService = dataService
    }

    func fetchAccounts() async {
        isLoading = true
        errorMessage = nil
        do {
            let accounts = try await dataService.getAccounts()
            self.accounts = accounts.map { AccountViewModel(account: $0) }
        } catch {
            errorMessage = "Failed to load accounts: \(error.localizedDescription)"
            isLoading = false
        }
        isLoading = false
    }
}


