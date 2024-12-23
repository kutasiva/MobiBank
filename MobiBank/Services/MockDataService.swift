//
//  MockDataService.swift
//  MobiBank
//
//  Created by kutasov on 23.12.2024.
//

struct MockDataService: DataServiceProtocol {
    func getAccounts() async throws -> [Account] {
        let mockAccounts = [
            Account(
                accountNumber: "000000-0109213309",
                bankCode: "0800",
                transparencyFrom: "2015-01-24T00:00:00",
                transparencyTo: "3000-01-01T00:00:00",
                publicationTo: "3000-01-01T00:00:00",
                actualizationDate: "2018-01-17T13:00:00",
                balance: 165939.97,
                currency: "CZK",
                name: "Společenství Praha 4, Obětí 6.května 553",
                iban: "CZ75 0800 0000 0001 0921 3309"
            ),
            Account(
                accountNumber: "000000-0460043319",
                bankCode: "0800",
                transparencyFrom: "2015-04-08T00:00:00",
                transparencyTo: "3000-01-01T00:00:00",
                publicationTo: "3000-01-01T00:00:00",
                actualizationDate: "2018-01-17T13:00:18",
                balance: 899886.56,
                currency: "CZK",
                name: "Obec Nová Ves",
                iban: "CZ63 0800 0000 0004 6004 3319"
            ),
        ]

        return mockAccounts
    }
}
