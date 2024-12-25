//
//  ContentView.swift
//  MobiBank
//
//  Created by kutasov on 23.12.2024.
//

import SwiftUI

struct AccountListView: View {
    @State private var viewModel: AccountListViewModel

    init(dataService: DataServiceProtocol) {
        viewModel = AccountListViewModel(dataService: dataService)
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
        if viewModel.isLoading {
            ProgressView(Strings.AccountTransactions.loadingMessage)
        } else if let errorMessage = viewModel.errorMessage {
            Text(errorMessage)
                .foregroundColor(.red)
        } else {
            List(viewModel.accounts) { account in
                NavigationLink(destination: AccountTransactionsView(dataService: viewModel.dataService, accountId: account.accountNumber)) {
                    VStack(alignment: .leading) {
                        Text(account.name)
                            .font(.headline)
                        Text("\(Strings.AccountList.accountNumber)\(account.accountNumber)")
                        Text("\(Strings.AccountList.balance)\(account.balance) \(account.currency)")
                    }
                    .padding()
                }
            }
        }
    }
}

struct AccountTransactionsView: View {
    @State private var viewModel: TransactionListViewModel

    init(dataService: DataServiceProtocol, accountId: String) {
        viewModel = TransactionListViewModel(acountId: accountId, dataService: dataService)
    }

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView(Strings.AccountTransactions.loadingMessage)
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            } else {
                List(viewModel.accountTransactions) { transactionViewModel in
                    VStack(alignment: .leading) {
                        Text("\(Strings.AccountTransactions.amount)\(transactionViewModel.amount.value) \(transactionViewModel.amount.currency)")
                        Text("\(Strings.AccountTransactions.type)\(transactionViewModel.type)")
                        if let dueDate = transactionViewModel.dueDate {
                            Text("\(Strings.AccountTransactions.dueDate)\(dueDate, formatter: dateFormatter)")
                        }

                        if let processingDate = transactionViewModel.processingDate {
                            Text("\(Strings.AccountTransactions.processingDate)\(processingDate, formatter: dateFormatter)")
                        }

                        Text("\(Strings.AccountTransactions.sender)\(transactionViewModel.sender.accountNumber)")
                        Text("\(Strings.AccountTransactions.receiver)\(transactionViewModel.receiver.accountNumber)")
                        Text("\(Strings.AccountTransactions.description)\(transactionViewModel.typeDescription)")
                    }
                    .padding()
                }

                .navigationTitle(Strings.AccountTransactions.navigationTitle)
            }
        }
        .task {
            await viewModel.fetchAccountTransactions()
        }
    }
}

#Preview {
    let dataService = DataService()
    // let mock = MockDataService(data: "Mock data")
    AccountListView(dataService: dataService)
}
