//
//  TransactionsConfig.swift
//  AccountLedger
//
//  Created by Anastasia Lenina on 20.01.2025.
//

import Foundation

enum TransactionsConfig: CaseIterable {
    case amount
    case processingDate
    case type
    
    func texts(for transaction: TransactionDetail) -> (label: String, value: String) {
        switch self {
        case .amount:
            let amount = String(format: "%.2f", transaction.amount.value)
            return ("Amount:", "\(amount) \(transaction.amount.currency)")
        case .processingDate:
            return ("Processing Date:", transaction.processingDate.formatAsMediumDate())
        case .type:
            return ("Type:", transaction.typeDescription)
        }
    }
}
