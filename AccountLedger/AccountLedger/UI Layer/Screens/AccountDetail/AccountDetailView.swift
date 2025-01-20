//
//  AccountDetailView.swift
//  AccountLedger
//
//  Created by Anastasia Lenina on 19.01.2025.
//

import Charts
import SwiftUI

struct AccountDetailView: View {
    @StateObject var viewModel: AccountDetailViewModel
   
    var body: some View {
        content()
            .onAppear {
                viewModel.fetchTransactions()
            }
    }
}

private extension AccountDetailView {
    @ViewBuilder
    func content() -> some View {
        VStack {
            switch viewModel.viewState {
            case .loading:
                ProgressView("Loading Transactions...")
            case .empty:
                ContentUnavailableView("No transactions available.", systemImage: "questionmark.app.dashed")
            case .content:
                contentList()
            }
        }
        .navigationTitle("Transactions")
    }
    
    @ViewBuilder
    func contentList() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            titleText("Monthly Cash Flow")
            chartView()
            titleText("Transactions")
            transactionsList()
        }
    }
    
    @ViewBuilder
    func transactionsList() -> some View {
        List(viewModel.transactions.sorted(by: { $0.processingDate < $1.processingDate }), id: \.id) { transaction in
            transactionRow(transaction)
        }
        .listStyle(.plain)
    }
    
    @ViewBuilder
    func transactionRow(_ transaction: TransactionDetail) -> some View {
        VStack(spacing: 10) {
            ForEach(TransactionsConfig.allCases, id: \.self) { rowConfig in
                switch rowConfig {
                case .amount:
                    amountRow(subtitle: rowConfig.texts(for: transaction).label, transaction: transaction)
                case .processingDate, .type:
                    simpleRow(rowConfig.texts(for: transaction))
                }
            }
        }
    }
    
    @ViewBuilder
    func simpleRow(_ data: (label: String, value: String)) -> some View {
        HStack {
            subtitleText(data.label)
            valueText(data.value)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    func amountRow(subtitle: String, transaction: TransactionDetail) -> some View {
        HStack(alignment: .bottom) {
            subtitleText(subtitle)
            amountText(transaction)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    func subtitleText(_ text: String) -> some View {
        Text(text)
            .font(.system(size: 14, weight: .black))
            .foregroundStyle(Color.black.opacity(0.7))
    }
    
    @ViewBuilder
    func valueText(_ text: String) -> some View {
        Text(text)
            .font(.system(size: 14, weight: .medium))
            .foregroundStyle(Color.gray)
    }
    
    @ViewBuilder
    func amountText(_ transaction: TransactionDetail) -> some View {
        Text("\(transaction.amount.value, specifier: "%.2f") \(transaction.amount.currency)")
            .foregroundColor(transaction.amount.value > 0 ? .green : .red)
            .font(.system(size: 16, weight: .black))
    }
    
    @ViewBuilder
    func titleText(_ text: String) -> some View {
        Text(text)
            .font(.system(size: 20, weight: .black))
            .padding(.horizontal)
            .padding(.top, 32)
    }
}

// MARK: - Chart Section
private extension AccountDetailView {
    @ViewBuilder
    func chartView() -> some View {
        Chart(viewModel.monthlyCashFlow, id: \.month) { data in
            BarMark(
                x: .value("Month", data.month),
                y: .value("Total", data.total)
            )
            .foregroundStyle(data.total > 0 ? .green : .red)
            .annotation(position: .top) {
                annotationView(data)
            }
        }
        .chartScrollableAxes(.horizontal)
        .frame(height: 300)
        .chartYScale(domain: viewModel.minValueWithBuffer...viewModel.maxValueWithBuffer)
        .padding()
    }
    
    @ViewBuilder
    func annotationView(_ data: (month: String, total: Double)) -> some View {
        Text("\(data.total, specifier: "%.2f")")
            .font(.system(size: 12, weight: .black))
            .foregroundColor(.primary)
    }
}

#Preview {
    AccountDetailView(viewModel: AccountDetailViewModel(accountNumber: "000000-2906478309"))
}
