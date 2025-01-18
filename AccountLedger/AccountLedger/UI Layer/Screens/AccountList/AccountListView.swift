//
//  AccountListView.swift
//  AccountLedger
//
//  Created by Anastasia Lenina on 18.01.2025.
//

import SwiftUI

struct AccountListView: View {
    @ObservedObject var viewModel = AccountListViewModel() // Dependency injection will be introduced later
    
    var body: some View {
        Text("Account List")
            .onAppear {
                viewModel.fetchAccounts()
            }
    }
}

#Preview {
    AccountListView()
}
