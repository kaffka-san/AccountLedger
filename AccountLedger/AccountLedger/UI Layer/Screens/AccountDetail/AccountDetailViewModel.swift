//
//  AccountDetailViewModel.swift
//  AccountLedger
//
//  Created by Anastasia Lenina on 19.01.2025.
//

import Foundation

final class AccountDetailViewModel: ObservableObject, ViewStateProvider {
    let accountNumber: String
    private let accountsService = AccountsService(apiManager: APICommunication())
    @Published var transactions = [TransactionDetail]()
    @Published var isLoading: Bool = false
    
    init(accountNumber: String) {
        self.accountNumber = accountNumber
    }
}

// MARK: - Public properties
extension AccountDetailViewModel {
    // data for the chart
    var monthlyCashFlow: [(month: String, total: Double)] {
        let transactionsGroupedByMonth = groupTransactionsByMonth()
        let sortedMonthlyTotals = calculateMonthlyTotals(transactionsGroupedByMonth)
        
        return sortedMonthlyTotals.map { (month: $0.month, total: $0.total) }
    }
    
    var maxValueWithBuffer: Double {
        let max = monthlyCashFlow.map { $0.total }.max() ?? 0
        return max + (0.2 * max)
    }

    var minValueWithBuffer: Double {
        let min = monthlyCashFlow.map { $0.total }.min() ?? 0
        return min - (0.2 * min)
    }
    
    var viewState: ViewState {
        viewState(for: { transactions.isEmpty })
    }
}

// MARK: - Public methods
extension AccountDetailViewModel {
    @MainActor
    func fetchTransactions() {
        isLoading = true
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
    func groupTransactionsByMonth() -> [String: [TransactionDetail]] {
        Dictionary(grouping: transactions) { transaction in
            transaction.processingDate.formatAsMonthYear()
        }
    }
    
    func calculateMonthlyTotals(_ groupedTransactions: [String: [TransactionDetail]]) -> [(month: String, total: Double, firstDate: Date)] {
        groupedTransactions.map { (month, transactions) in
            let total = transactions.reduce(0) { $0 + $1.amount.value }
            let firstDate = transactions.first?.processingDate ?? Date()
            return (month: month, total: total, firstDate: firstDate)
        }
        .sorted { $0.firstDate < $1.firstDate }
    }
}
