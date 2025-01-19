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
        content()
            .onAppear {
                viewModel.fetchAccounts()
            }
    }
}

extension AccountListView {
    @ViewBuilder
    func content() -> some View {
        NavigationStack {
            ZStack {
                contentList()
                progressView()
            }
            .accentColor(.gray)
            .navigationTitle("Accounts")
            .navigationDestination(item: $selectedAccountId) { accountId in
                AccountDetailView(accountNumber: accountId)
            }
        }
    }
    
    @ViewBuilder
    func contentList() -> some View {
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
    
    @ViewBuilder
    func progressView() -> some View {
        if viewModel.isLoading {
            ProgressView()
        }
    }
}

#Preview {
    AccountListView()
}
