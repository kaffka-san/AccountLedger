//
//  AlertAction.swift
//  AccountLedger
//
//  Created by Anastasia Lenina on 21.01.2025.
//

import Foundation

struct AlertAction {
    let title: String
    let action: () -> Void
}

struct AlertConfiguration: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    let action: AlertAction?

    init(
        title: String,
        message: String,
        action: AlertAction? = nil
    ) {
        self.title = title
        self.message = message
        self.action = action
    }
}
