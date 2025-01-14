//
//  ViewState.swift
//  MobiBank
//
//  Created by kutasov on 14.01.2025.
//

import Foundation

enum ViewState<Content> {
    case idle
    case loading
    case loaded(Content)
    case error(String)
}
