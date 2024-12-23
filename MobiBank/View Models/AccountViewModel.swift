//
//  AccountViewModel.swift
//  MobiBank
//
//  Created by kutasov on 23.12.2024.
//

import Foundation

struct AccountViewModel: Identifiable {
    let id = UUID()
    let account: Account

    var accountNumber: String {
        account.accountNumber
    }

    var bankCode: String {
        account.bankCode
    }

    var transparencyFrom: String {
        account.transparencyFrom
    }

    var transparencyTo: String {
        account.transparencyTo
    }

    var publicationTo: String {
        account.publicationTo
    }

    var actualizationDate: String {
        account.actualizationDate
    }

    var balance: String {
        String(format: "%.2f", account.balance)
    }

    var currency: String {
        account.currency ?? ""
    }

    var name: String {
        account.name
    }

    var iban: String {
        account.iban
    }
}
