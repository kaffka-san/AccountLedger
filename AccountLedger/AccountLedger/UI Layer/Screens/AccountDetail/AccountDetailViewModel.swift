//
//  AccountDetailViewModel.swift
//  AccountLedger
//
//  Created by Anastasia Lenina on 19.01.2025.
//

import Foundation

final class AccountDetailViewModel: ObservableObject {
    @Published var isLoading: Bool = false
}

// MARK: - Public methods
extension AccountListViewModel {
    @MainActor
    func fetchTransactions() {
    }
}

// MARK: - Private methods
extension AccountDetailViewModel {
}
