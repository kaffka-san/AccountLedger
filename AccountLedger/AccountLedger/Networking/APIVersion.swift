//
//  APIVersion.swift
//  AccountLedger
//
//  Created by Anastasia Lenina on 18.01.2025.
//

import Foundation

enum ApiVersion: String, Codable {
    case version1 = "v1"
    case version2 = "v2"
    case version3 = "v3"

    static var defaultVersion: ApiVersion {
        .version3
    }
}
