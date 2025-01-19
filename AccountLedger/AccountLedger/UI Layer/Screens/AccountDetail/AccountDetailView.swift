//
//  AccountDetailView.swift
//  AccountLedger
//
//  Created by Anastasia Lenina on 19.01.2025.
//

import SwiftUI

struct AccountDetailView: View {
    @ObservedObject var viewModel = AccountDetailViewModel()
    var body: some View {
        Text("Account Detail")
    }
}

#Preview {
    AccountDetailView()
}
