//
//  AccountDetail.swift
//  MobiBank
//
//  Created by kutasov on 24.12.2024.
//

import Foundation

struct AccountTransactionsResponse: Decodable {
    let pageNumber: Int
    let pageSize: Int
    let pageCount: Int
    let nextPage: Int?
    let recordCount: Int
    let transactions: [Transaction]
}

struct Transaction: Decodable, Equatable {
    let amount: Amount
    let type: String
    let dueDate: Date
    let processingDate: Date
    let sender: AccountDetail
    let receiver: AccountDetail
    let typeDescription: String

    static func ==(lhs: Transaction, rhs: Transaction) -> Bool {
        return lhs.amount == rhs.amount &&
            lhs.type == rhs.type &&
            lhs.dueDate == rhs.dueDate &&
            lhs.processingDate == rhs.processingDate &&
            lhs.sender == rhs.sender &&
            lhs.receiver == rhs.receiver &&
            lhs.typeDescription == rhs.typeDescription
    }
}

struct Amount: Decodable, Equatable {
    let value: Double
    let precision: Int
    let currency: String

    static func ==(lhs: Amount, rhs: Amount) -> Bool {
        return lhs.value == rhs.value &&
            lhs.precision == rhs.precision &&
            lhs.currency == rhs.currency
    }
}

struct AccountDetail: Decodable, Equatable {
    let accountNumber: String
    let bankCode: String
    let iban: String
    let specificSymbol: String?
    let specificSymbolParty: String?
    let constantSymbol: String?
    let variableSymbol: String?
    let name: String?
    let description: String?

    static func ==(lhs: AccountDetail, rhs: AccountDetail) -> Bool {
        return lhs.accountNumber == rhs.accountNumber &&
            lhs.bankCode == rhs.bankCode &&
            lhs.iban == rhs.iban &&
            lhs.specificSymbol == rhs.specificSymbol &&
            lhs.specificSymbolParty == rhs.specificSymbolParty &&
            lhs.constantSymbol == rhs.constantSymbol &&
            lhs.variableSymbol == rhs.variableSymbol &&
            lhs.name == rhs.name &&
            lhs.description == rhs.description
    }
}
