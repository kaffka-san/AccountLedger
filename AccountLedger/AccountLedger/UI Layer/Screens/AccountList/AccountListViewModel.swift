//
//  AccountListViewModel.swift
//  AccountLedger
//
//  Created by Anastasia Lenina on 18.01.2025.
//

import Foundation

final class AccountListViewModel: ObservableObject {
    private let apiCommunication = APICommunication()
    @Published var accounts: [TransparentAccount] = []
    @Published var isLoading: Bool = false
}

// MARK: - Public methods
extension AccountListViewModel {
    @MainActor
    func fetchAccounts() {
        Task { [weak self] in
            guard let self else { return }
            do {
                let data: AccountResponse = try await apiCommunication.request()
                accounts = data.accounts
                isLoading = false
                print("data: \(accounts)")
            } catch {
                // TODO: show alert
                isLoading = false
            }
        }
    }
}

// MARK: - Private methods
extension AccountListViewModel {
}
