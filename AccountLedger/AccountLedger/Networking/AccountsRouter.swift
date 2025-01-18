//
//  AccountsRouter.swift
//  AccountLedger
//
//  Created by Anastasia Lenina on 18.01.2025.
//

import Foundation

enum AccountsRouter {
    case getAccounts(page: Int, itemsCount: Int)
}

extension AccountsRouter {
    var path: String {
        switch self {
        case .getAccounts:
            return "transparentAccounts"
        }
    }
    
    var parameters: [URLQueryItem]? {
        switch self {
        case let .getAccounts(page, itemsCount):
            return [
                URLQueryItem(name: "size", value: "\(itemsCount)"),
                URLQueryItem(name: "page", value: "\(page)")
            ]
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getAccounts:
            return .get
        }
    }
    
    var apiVersion: ApiVersion {
        ApiVersion.defaultVersion
    }
    
    var baseURLComponents: URLComponents {
        var components = URLComponents()
        components.scheme = AccountLedgerAPI().urlScheme
        components.host = AccountLedgerAPI().urlHost
        components.path = AccountLedgerAPI().urlPath
        components.queryItems = parameters

        return components
    }

    var urlRequest: URLRequest? {
        guard let url = baseURLComponents.url else { return nil }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(APIKey.primary, forHTTPHeaderField: "WEB-API-key")
        request.setValue(apiVersion.rawValue, forHTTPHeaderField: "api-version")
        request.url?.appendPathComponent("\(apiVersion.rawValue)/\(path)")
        request.httpMethod = httpMethod.rawValue
        return request
    }

    func createUrlRequest() throws -> URLRequest {
        guard let urlRequest = urlRequest else {
            throw NetworkingError.invalidURL
        }
        return urlRequest
    }
}
