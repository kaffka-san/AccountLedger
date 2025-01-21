//
//  AccountListView.swift
//  AccountLedger
//
//  Created by Anastasia Lenina on 18.01.2025.
//

import SwiftUI

struct AccountListView: View {
    @ObservedObject var viewModel = AccountListViewModel() // Dependency injection will be introduced later
    @State private var selectedAccountId: String?
    
    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Accounts")
                .navigationDestination(item: $selectedAccountId) { accountId in
                    AccountDetailView(viewModel: AccountDetailViewModel(accountNumber: accountId))
                }
                .onAppear {
                    viewModel.fetchAccounts()
                }
                .alert(item: $viewModel.alertConfig) { item in
                    Alert(title: Text(item.title), message: Text(item.message))
                }
        }
        .accentColor(.gray)
    }
}

extension AccountListView {
    var content: some View {
        VStack {
            switch viewModel.viewState {
            case .loading:
                ProgressView("Loading Accounts...")
            case .empty:
                ContentUnavailableView("No accounts available.", systemImage: "questionmark.app.dashed")
            case .content:
                contentList
            }
        }
    }
    
    var contentList: some View {
        List(viewModel.accounts) { account in
            row(for: account)
        }
        .listStyle(.automatic)
    }
    
    @ViewBuilder
    func row(for account: TransparentAccount) -> some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 8) {
                accountName(account.name)
                accountNumber(account.accountNumber)
            }
            Spacer()
            balance(balance: account.balance, currency: account.currency)
        }
        .padding(.vertical)
        .contentShape(Rectangle())
        .onTapGesture {
            selectedAccountId = account.accountNumber
        }
    }
    
    @ViewBuilder
    func accountName(_ name: String) -> some View {
        Text(name)
            .font(.system(size: 12, weight: .black))
            .foregroundStyle(.black.opacity(0.7))
    }
    
    @ViewBuilder
    func accountNumber(_ number: String) -> some View {
        Text(number)
            .font(.system(size: 12, weight: .black))
            .foregroundStyle(.black.opacity(0.2))
    }
    
    @ViewBuilder
    func balance(balance: Double, currency: String?) -> some View {
        Text("\(balance, specifier: "%.2f") \(currency ?? "")")
            .font(.system(size: 14, weight: .black))
    }
}

#Preview {
    AccountListView()
}
