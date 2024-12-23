//
//  MobiBankApp.swift
//  MobiBank
//
//  Created by kutasov on 23.12.2024.
//

import SwiftUI

@main
struct MobiBankApp: App {
    var body: some Scene {
        let dataService = DataSerivce()
        let mockDataService = MockDataService()
        WindowGroup {
            ContentView(dataService: dataService)
        }
    }
}
