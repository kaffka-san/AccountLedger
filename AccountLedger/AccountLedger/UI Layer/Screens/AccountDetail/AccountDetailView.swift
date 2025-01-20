//
//  AccountDetailView.swift
//  AccountLedger
//
//  Created by Anastasia Lenina on 19.01.2025.
//

import SwiftUI

struct AccountDetailView: View {
    @StateObject var viewModel: AccountDetailViewModel
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
