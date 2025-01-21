//
//  Date+Ext.swift
//  AccountLedger
//
//  Created by Anastasia Lenina on 20.01.2025.
//

import Foundation

extension Date {
    func formatAsMonthYear() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        return formatter.string(from: self)
    }
    
    func formatAsMediumDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: self)
    }
}
