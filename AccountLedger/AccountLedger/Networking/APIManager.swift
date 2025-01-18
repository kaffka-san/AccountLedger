//
//  APIManager.swift
//  AccountLedger
//
//  Created by Anastasia Lenina on 18.01.2025.
//

import Foundation

protocol APIManager {
    func request<T: Decodable>(request: APIConvertible) async throws -> T
}
