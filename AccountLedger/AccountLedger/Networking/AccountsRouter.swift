//
//  AccountsRouter.swift
//  AccountLedger
//
//  Created by Anastasia Lenina on 18.01.2025.
//

import Foundation

enum AccountsRouter: APIConvertible {
    case getAccounts(page: Int, itemsCount: Int)
    case getTransactions(accountNumber: String, page: Int, itemsCount: Int)
}

extension AccountsRouter {
    var path: String {
        switch self {
        case .getAccounts:
            return "transparentAccounts"
        case .getTransactions(let accountNumber, _, _):
            return "\(accountNumber)/transactions"
        }
    }
    
    var parameters: [URLQueryItem]? {
        switch self {
        case let .getAccounts(page, itemsCount):
            return [
                URLQueryItem(name: "size", value: "\(itemsCount)"),
                URLQueryItem(name: "page", value: "\(page)")
            ]
        case let .getTransactions(_, page, itemsCount):
            return [
                URLQueryItem(name: "size", value: "\(itemsCount)"),
                URLQueryItem(name: "page", value: "\(page)")
            ]
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getAccounts, .getTransactions:
            return .get
        }
    }
    
    func createURLRequest() throws -> URLRequest {
        guard let urlRequest = urlRequest else {
            throw NetworkingError.invalidURL
        }
        return urlRequest
    }
}
