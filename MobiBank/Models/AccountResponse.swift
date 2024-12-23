//
//  ResponseAccount.swift
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
