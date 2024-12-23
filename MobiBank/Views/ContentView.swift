//
//  ContentView.swift
//  MobiBank
//
//  Created by kutasov on 23.12.2024.
//

import SwiftUI

struct ContentView: View {
    let viewModel: AccountListViewModel

    init(dataService: DataServiceProtocol) {
        self.viewModel = AccountListViewModel(dataService: dataService)
    }

    var body: some View {
        NavigationView {
            content
                .navigationTitle("Accounts")
                .onAppear {
                    Task {
                        await viewModel.getAccounts()
                    }
                }
        }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading {
            ProgressView("Loading...")
        } else if let errorMessage = viewModel.errorMessage {
            Text(errorMessage)
                .foregroundColor(.red)
        } else {
            List(viewModel.accounts) { account in
                VStack(alignment: .leading) {
                    Text(account.name)
                        .font(.headline)
                    Text("Account Number: \(account.accountNumber)")
                    Text("Balance: \(account.balance) \(account.currency)")
                }
                .padding()
            }
        }
    }
}

#Preview {
    let viewModel = DataSerivce()
    // let mock = MockDataService(data: "Mock data")
    ContentView(dataService: viewModel)
}
