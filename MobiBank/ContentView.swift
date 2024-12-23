//
//  ContentView.swift
//  MobiBank
//
//  Created by kutasov on 23.12.2024.
//

import SwiftUI

protocol DataServiceProtocol {
    func getTitle() async -> String
}

actor DataSerivce: DataServiceProtocol {
    func getTitle() async -> String {
        try? await Task.sleep(for: .seconds(1))
        return "Updated title"
    }
}

actor MockDataService: DataServiceProtocol {
    let testData: String

    init(data: String? = nil) {
        self.testData = data ?? "testData"
    }

    func getTitle() async -> String {
        try? await Task.sleep(for: .seconds(1))
        return "Mock title"
    }
}

@MainActor
@Observable class BankAccountViewModel {
    private let dataSerivce: DataServiceProtocol

    var title: String = "Starting title"

    init(dataSerivce: DataServiceProtocol) {
        self.dataSerivce = dataSerivce
    }

    func updateTitle() async {
        title = await dataSerivce.getTitle()
    }
}

struct ContentView: View {
    let viewModel: BankAccountViewModel

    init(dataSerivce: DataServiceProtocol) {
        self.viewModel = BankAccountViewModel(dataSerivce: dataSerivce)
    }

    var body: some View {
        VStack {
            Text(viewModel.title)
                .task {
                    await viewModel.updateTitle()
                }
        }
        .padding()
    }
}

#Preview {
    let viewModel = DataSerivce()
    let mock = MockDataService(data: "Mock data")
    ContentView(dataSerivce: mock)
}
