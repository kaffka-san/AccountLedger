//
//  NetworkingError.swift
//  AccountLedger
//
//  Created by Anastasia Lenina on 18.01.2025.
//

import Foundation

enum NetworkingError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case genericError
    case unknown(_ error: Error)
}

extension NetworkingError {
    var localizedDescription: ErrorDescription {
        switch self {
        case .genericError:
            return ErrorDescription("Error", "Something went wrong")
        case .invalidURL:
            return ErrorDescription("Error", "The URL provided is invalid")
        case .invalidData:
            return ErrorDescription("Invalid Data", "The data received is invalid")
        case .invalidResponse:
            return ErrorDescription("Invalid Response", "We encountered an invalid response. Please refresh or contact support if the issue persists.")
            
        case .unknown:
            return ErrorDescription("Unknown Error", "An unknown error occurred")
        }
    }
}

extension NetworkingError {
    struct ErrorDescription {
        let title: String
        let message: String
        
        init(_ title: String, _ message: String) {
            self.title = title
            self.message = message
        }
    }
    
    static func map(_ error: Error) -> NetworkingError {
        (error as? NetworkingError) ?? .unknown(error)
    }
}
