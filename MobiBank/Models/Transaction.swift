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
}

struct Amount: Decodable, Equatable {
    let value: Double
    let precision: Int
    let currency: String
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
}
