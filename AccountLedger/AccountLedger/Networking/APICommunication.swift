//
//  APICommunication.swift
//  AccountLedger
//
//  Created by Anastasia Lenina on 18.01.2025.
//

import Foundation
import UIKit

final class APICommunication {
    func request<T: Decodable>(request: AccountsRouter) async throws -> T {
        do {
            let urlRequest = try request.createUrlRequest()
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  200..<300 ~= httpResponse.statusCode
            else {
                // TODO: throw Networking Error
                throw NSError(domain: "Static code error", code: -1)
            }
            
            return try decoder.decode(T.self, from: data)
        } catch {
            // TODO: throw Networking Error
            throw NSError(domain: "Networking error", code: -1)
        }
        
    }
    
    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }
}
