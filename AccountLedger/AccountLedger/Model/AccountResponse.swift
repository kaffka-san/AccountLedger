//
//  AccountResponse.swift
//  AccountLedger
//
//  Created by Anastasia Lenina on 18.01.2025.
//

import Foundation

struct AccountResponse: Codable {
    let pageNumber: Int
    let pageCount: Int
    let pageSize: Int
    let recordCount: Int
    let nextPage: Int?
    let accounts: [TransparentAccount]
}

struct TransparentAccount: Codable, Identifiable {
    var id: String {
        return accountNumber
    }
    let accountNumber: String
    let bankCode: String
    let transparencyFrom: Date
    let transparencyTo: Date
    let publicationTo: Date
    let actualizationDate: Date
    let balance: Double
    let currency: String?
    let name: String
    let description: String?
    let note: String?
    let iban: String
    let statements: [String]?
}
