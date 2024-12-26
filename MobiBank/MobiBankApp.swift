//
//  MobiBankApp.swift
//  MobiBank
//
//  Created by kutasov on 23.12.2024.
//

import SwiftUI

@main
struct MobiBankApp: App {
    private var dataService = DataService()
    private var mockDataService = MockDataService()
    var body: some Scene {
        WindowGroup {
            AccountListView(dataService: dataService)
        }
    }
}
