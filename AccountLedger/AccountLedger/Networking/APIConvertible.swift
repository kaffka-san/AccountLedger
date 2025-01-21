//
//  APIConvertible.swift
//  AccountLedger
//
//  Created by Anastasia Lenina on 18.01.2025.
//

import Foundation

protocol APIConvertible {
    var path: String { get }
    var parameters: [URLQueryItem]? { get }
    var httpMethod: HTTPMethod { get }
    var baseURLComponents: URLComponents { get }
   
    func createURLRequest() throws -> URLRequest
}

extension APIConvertible {
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
        request.url?.appendPathComponent("\(ApiVersion.defaultVersion.rawValue)/\(path)")
        request.httpMethod = httpMethod.rawValue
        return request
    }
}
