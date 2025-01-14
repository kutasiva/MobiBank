//
//  ContentView.swift
//  MobiBank
//
//  Created by kutasov on 23.12.2024.
//

import SwiftUI

struct AccountListView: View {
    private var viewModel: AccountListViewModel

    init(accountService: AccountServiceProtocol) {
        viewModel = AccountListViewModel(accountService: accountService)
    }

    var body: some View {
        NavigationView {
            content
        }
        .task {
            await viewModel.fetchAccounts()
        }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.viewState {
        case .loading:
            ProgressView(Strings.AccountTransactions.loadingMessage)
        case .loaded(let accounts):
            List(accounts) { account in
                NavigationLink(destination: AccountTransactionsView(accountService: viewModel.accountService, accountId: account.account.accountNumber)) {
                    VStack(alignment: .leading) {
                        Text(account.name)
                            .font(.headline)
                        Text("\(Strings.AccountList.accountNumber)\(account.accountNumber)")
                        Text("\(Strings.AccountList.balance)\(account.balance) \(account.currency)")
                    }
                    .padding()
                }
            }
        case .error(let message):
            Text(message)
                .foregroundColor(.red)
        case .idle:
            EmptyView()
        }
    }
}

#Preview {
    let accountService = AccountService(networkService: NetworkService())
    AccountListView(accountService: accountService)
}
