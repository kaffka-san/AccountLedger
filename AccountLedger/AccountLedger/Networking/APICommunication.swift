//
//  APICommunication.swift
//  AccountLedger
//
//  Created by Anastasia Lenina on 18.01.2025.
//

import Foundation
import UIKit

final class APICommunication: APIManager {
    func request<T: Decodable>(request: APIConvertible) async throws -> T {
        do {
            let urlRequest = try request.createURLRequest()
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  200..<300 ~= httpResponse.statusCode
            else {
                throw NetworkingError.invalidResponse
            }
            
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkingError.map(error)
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
