//
//  AccountsService.swift
//  AccountLedger
//
//  Created by Anastasia Lenina on 18.01.2025.
//

import Foundation

protocol AccountsServiceProtocol {
    func getAccounts(page: Int, itemsCount: Int) async throws -> AccountResponse
    func getTransactions(accountNumber: String, page: Int, itemsCount: Int) async throws -> TransactionsResponse
}

final class AccountsService: AccountsServiceProtocol {
    private let apiManager: APIManager
    
    init(apiManager: APIManager) {
        self.apiManager = apiManager
    }
    
    func getAccounts(page: Int, itemsCount: Int) async throws -> AccountResponse {
        try await apiManager.request(request: AccountsRouter.getAccounts(page: page, itemsCount: itemsCount))
    }
    
    func getTransactions(accountNumber: String, page: Int, itemsCount: Int) async throws -> TransactionsResponse {
        try await apiManager.request(
            request: AccountsRouter.getTransactions(
                accountNumber: accountNumber,
                page: page,
                itemsCount: itemsCount
            )
        )
    }
}
