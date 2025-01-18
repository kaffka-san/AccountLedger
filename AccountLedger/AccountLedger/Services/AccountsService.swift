//
//  AccountsService.swift
//  AccountLedger
//
//  Created by Anastasia Lenina on 18.01.2025.
//

import Foundation

protocol AccountsServiceProtocol {
    func getAccounts(page: Int, itemsCount: Int) async throws -> AccountResponse
}

final class AccountsService: AccountsServiceProtocol {
    private let apiCommunication: APICommunication
    
    init(apiCommunication: APICommunication) {
        self.apiCommunication = apiCommunication
    }
    
    func getAccounts(page: Int, itemsCount: Int) async throws -> AccountResponse {
        try await apiCommunication.request(request: AccountsRouter.getAccounts(page: page, itemsCount: itemsCount))
    }
}
