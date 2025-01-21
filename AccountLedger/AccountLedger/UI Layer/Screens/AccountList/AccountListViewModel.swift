//
//  AccountListViewModel.swift
//  AccountLedger
//
//  Created by Anastasia Lenina on 18.01.2025.
//

import Foundation

final class AccountListViewModel: ObservableObject, ViewStateProvider {
    private let accountsService = AccountsService(apiManager: APICommunication())
    @Published var accounts: [TransparentAccount] = []
    @Published var isLoading: Bool = false
    @Published var alertConfig: AlertConfiguration?
}

// MARK: - Public properties
extension AccountListViewModel {
    var viewState: ViewState {
        viewState(for: { accounts.isEmpty })
    }
}

// MARK: - Public methods
extension AccountListViewModel {
    @MainActor
    func fetchAccounts() {
        Task { [weak self] in
            guard let self else { return }
            do {
                let data = try await accountsService.getAccounts(page: 0, itemsCount: 50)
                accounts = data.accounts
                isLoading = false
            } catch let error as NetworkingError {
                showAlert(for: error)
                isLoading = false
            }
        }
    }
}

// MARK: - Private methods
extension AccountListViewModel {
    func showAlert(for error: NetworkingError) {
        alertConfig = AlertConfiguration(
            title: error.localizedDescription.title,
            message: error.localizedDescription.message
        )
    }
}
