//
//  AccountDetailViewModel.swift
//  MobiBank
//
//  Created by kutasov on 24.12.2024.
//

import Foundation

struct TransactionViewModel: Identifiable {
    let id = UUID()
    let transaction: Transaction

    var amount: AmountViewModel {
        AmountViewModel(amount: transaction.amount)
    }

    var type: String {
        transaction.type
    }

    var dueDate: Date? {
        transaction.dueDate
    }

    var processingDate: Date? {
        transaction.processingDate
    }

    var sender: AccountDetailViewModel {
        AccountDetailViewModel(accountDetail: transaction.sender)
    }

    var receiver: AccountDetailViewModel {
        AccountDetailViewModel(accountDetail: transaction.receiver)
    }

    var typeDescription: String {
        transaction.typeDescription
    }
}

struct AmountViewModel {
    let amount: Amount

    var value: String {
        String(format: "%.2f", amount.value)
    }

    var precision: Int {
        amount.precision
    }

    var currency: String {
        amount.currency
    }
}

struct AccountDetailViewModel {
    let accountDetail: AccountDetail

    var accountNumber: String {
        accountDetail.accountNumber
    }

    var bankCode: String {
        accountDetail.bankCode
    }

    var iban: String {
        accountDetail.iban
    }

    var specificSymbol: String? {
        accountDetail.specificSymbol
    }

    var specificSymbolParty: String? {
        accountDetail.specificSymbolParty
    }

    var constantSymbol: String? {
        accountDetail.constantSymbol
    }

    var variableSymbol: String? {
        accountDetail.variableSymbol
    }

    var name: String? {
        accountDetail.name
    }

    var description: String? {
        accountDetail.description
    }
}
