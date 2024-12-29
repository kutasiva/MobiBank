//
//  Account.swift
//  MobiBank
//
//  Created by kutasov on 23.12.2024.
//

struct AccountResponse: Decodable {
    let pageNumber: Int
    let pageSize: Int
    let pageCount: Int
    let nextPage: Int
    let recordCount: Int
    let accounts: [Account]
}

struct Account: Decodable, Equatable {
    let accountNumber: String
    let bankCode: String
    let transparencyFrom: String
    let transparencyTo: String
    let publicationTo: String
    let actualizationDate: String
    let balance: Double
    let currency: String?
    let name: String
    let iban: String

    static func ==(lhs: Account, rhs: Account) -> Bool {
        return lhs.accountNumber == rhs.accountNumber &&
            lhs.bankCode == rhs.bankCode &&
            lhs.transparencyFrom == rhs.transparencyFrom &&
            lhs.transparencyTo == rhs.transparencyTo &&
            lhs.publicationTo == rhs.publicationTo &&
            lhs.actualizationDate == rhs.actualizationDate &&
            lhs.balance == rhs.balance &&
            lhs.currency == rhs.currency &&
            lhs.name == rhs.name &&
            lhs.iban == rhs.iban
    }
}
