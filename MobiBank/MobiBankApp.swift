//
//  MobiBankApp.swift
//  MobiBank
//
//  Created by kutasov on 23.12.2024.
//

import SwiftUI

@main
struct MobiBankApp: App {
    //@StateObject private var dataService = DataService()
    //@StateObject private var mockDataService = MockDataService()
    var body: some Scene {
        let dataService = DataService()
     //   let mockDataService = MockDataService()
        WindowGroup {
            AccountListView(dataService: dataService)
        }
    }
}
