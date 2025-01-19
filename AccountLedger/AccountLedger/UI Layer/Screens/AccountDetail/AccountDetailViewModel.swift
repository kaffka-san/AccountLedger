//
//  AccountDetailViewModel.swift
//  AccountLedger
//
//  Created by Anastasia Lenina on 19.01.2025.
//

import Foundation

final class AccountDetailViewModel: ObservableObject {
    let accountNumber: String
    private let accountsService = AccountsService(apiManager: APICommunication())
    @Published var transactions = [TransactionDetail]()
    @Published var isLoading: Bool = false
    
    init(accountNumber: String) {
        self.accountNumber = accountNumber
    }
}

// MARK: - Public methods
extension AccountDetailViewModel {
    @MainActor
    func fetchTransactions() {
        Task { [weak self] in
            guard let self else { return }
            do {
                let data = try await accountsService.getTransactions(accountNumber: accountNumber, page: 0, itemsCount: 50)
                transactions = data.transactions
                isLoading = false
            } catch {
                // TODO: show alert
                isLoading = false
            }
        }
    }
}

// MARK: - Private methods
extension AccountDetailViewModel {
}
