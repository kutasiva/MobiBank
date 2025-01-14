//
//  TransactionListView.swift
//  MobiBank
//
//  Created by kutasov on 02.01.2025.
//

import SwiftUI

struct AccountTransactionsView: View {
    private var viewModel: TransactionListViewModel

    init(accountService: AccountServiceProtocol, accountId: String) {
        viewModel = TransactionListViewModel(accountId: accountId, accountService: accountService)
    }

    var body: some View {
        VStack {
            switch viewModel.viewState {
                case .loading:
                    ProgressView(Strings.AccountTransactions.loadingMessage)
                case .error(let errorMessage):
                    Text(errorMessage)
                        .foregroundColor(.red)
                case .loaded(let transactionViewModels):
                    List(transactionViewModels) { transactionViewModel in
                        VStack(alignment: .leading) {
                            Text("\(Strings.AccountTransactions.amount)\(transactionViewModel.amount.value) \(transactionViewModel.amount.currency)")
                            Text("\(Strings.AccountTransactions.type)\(transactionViewModel.type)")
                            if let dueDate = transactionViewModel.dueDate {
                                Text("\(Strings.AccountTransactions.dueDate)\(dueDate, formatter: DateFormatter.shortStyle)")
                            }
                            if let processingDate = transactionViewModel.processingDate {
                                Text("\(Strings.AccountTransactions.processingDate)\(processingDate, formatter: DateFormatter.shortStyle)")
                            }
                            Text("\(Strings.AccountTransactions.sender)\(transactionViewModel.sender.accountNumber)")
                            Text("\(Strings.AccountTransactions.receiver)\(transactionViewModel.receiver.accountNumber)")
                            Text("\(Strings.AccountTransactions.description)\(transactionViewModel.typeDescription)")
                        }
                        .padding()
                    }
                    .navigationTitle(Strings.AccountTransactions.navigationTitle)
                case .idle:
                    EmptyView()
            }
        }
        .task {
            await viewModel.fetchAccountTransactions()
        }
    }
}

#Preview {
    let accountService = AccountService(networkService: NetworkService())
    AccountTransactionsView(accountService: accountService, accountId: "123456")
}
