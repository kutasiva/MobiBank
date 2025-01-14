//
//  DataFormatter.swift
//  MobiBank
//
//  Created by kutasov on 25.12.2024.
//
import Foundation

extension DateFormatter {
    static let shortStyle: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
}
