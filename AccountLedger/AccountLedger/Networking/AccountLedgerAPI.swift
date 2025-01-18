//
//  AccountLedgerAPI.swift
//  AccountLedger
//
//  Created by Anastasia Lenina on 18.01.2025.
//

import Foundation

struct AccountLedgerAPI: AccountLedgerAPIRepresentable {
    let urlScheme = "https"
    var urlHost: String {
        "webapi.developers.erstegroup.com"
    }

    let urlPath = "/api/csas/public/sandbox"
}

protocol AccountLedgerAPIRepresentable {
    var urlScheme: String { get }
    var urlHost: String { get }
    var urlPath: String { get }
}
