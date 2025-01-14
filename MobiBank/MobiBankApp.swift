//
//  MobiBankApp.swift
//  MobiBank
//
//  Created by kutasov on 23.12.2024.
//

import SwiftUI

@main
struct MobiBankApp: App {
    private var accountService = AccountService(networkService: NetworkService())
    // private var mockAccountService = MockAccountService()
    var body: some Scene {
        WindowGroup {
            AccountListView(accountService: accountService)
        }
    }
}
