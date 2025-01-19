//
//  AccountDetailView.swift
//  AccountLedger
//
//  Created by Anastasia Lenina on 19.01.2025.
//

import SwiftUI

struct AccountDetailView: View {
    @ObservedObject var viewModel: AccountDetailViewModel
    
    init(accountNumber: String) {
        self.viewModel = AccountDetailViewModel(accountNumber: accountNumber)
    }
    
    var body: some View {
        Text("Account Detail")
            .onAppear {
                viewModel.fetchTransactions()
            }
    }
}

#Preview {
    AccountDetailView(accountNumber: "5555")
}
