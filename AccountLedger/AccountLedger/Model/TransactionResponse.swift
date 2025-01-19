//
//  TransactionResponse.swift
//  AccountLedger
//
//  Created by Anastasia Lenina on 19.01.2025.
//

import Foundation

struct TransactionsResponse: Codable {
    let pageNumber: Int
    let pageSize: Int
    let pageCount: Int
    let nextPage: Int?
    let recordCount: Int
    let transactions: [TransactionDetail]
}

struct TransactionDetail: Codable, Identifiable {
    var id: String {
        UUID().uuidString
    }
    let amount: Amount
    let type: String
    let dueDate: Date
    let processingDate: Date
    let sender: Party
    let receiver: Party
    let typeDescription: String
}

struct Amount: Codable {
    let value: Double
    let precision: Int
    let currency: String
}

struct Party: Codable {
    let accountNumber: String
    let bankCode: String
    let iban: String
    let specificSymbol: String?
    let specificSymbolParty: String?
    let variableSymbol: String?
    let constantSymbol: String?
    let name: String?
    let description: String?
}

extension TransactionDetail {
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
    
    var formattedProcessingDate: String {
        return TransactionDetail.dateFormatter.string(from: processingDate)
    }
}
