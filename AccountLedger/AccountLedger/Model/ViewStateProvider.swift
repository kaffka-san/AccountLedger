//
//  ViewStateProvider.swift
//  AccountLedger
//
//  Created by Anastasia Lenina on 20.01.2025.
//

import Foundation

protocol ViewStateProvider {
    var isLoading: Bool { get }
    func viewState(for dataIsEmpty: () -> Bool) -> ViewState
}

extension ViewStateProvider {
    func viewState(for dataIsEmpty: () -> Bool) -> ViewState {
        switch (isLoading, dataIsEmpty()) {
        case (true, _):
            return .loading
        case (false, true):
            return .empty
        case (false, false):
            return .content
        }
    }
}
