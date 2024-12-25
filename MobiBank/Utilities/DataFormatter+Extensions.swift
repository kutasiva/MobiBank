//
//  DataFormatter.swift
//  MobiBank
//
//  Created by kutasov on 25.12.2024.
//
import Foundation

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
}()
