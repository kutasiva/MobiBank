//
//  JSONDecoderExtension.swift
//  MobiBank
//
//  Created by kutasov on 25.12.2024.
//

import Foundation

extension JSONDecoder {
    static let withCustomDateDecoding: JSONDecoder = {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
}
