//
//  APICommunication.swift
//  AccountLedger
//
//  Created by Anastasia Lenina on 18.01.2025.
//

import Foundation
import UIKit

final class APICommunication {
    private let baseURL = "https://webapi.developers.erstegroup.com/api/csas/public/sandbox/v3/transparentAccounts"
    private let apiKey = "ae7c985b-4ee8-421e-ae07-4d8c89731c2c"
    
    func request<T: Decodable>() async throws -> T {
        guard let url = URL(string: baseURL) else {
            // TODO: throw Networking Error
            throw NSError(domain: "Networking error", code: -1)
        }
        do {
            var urlRequest = URLRequest(url: url)
            urlRequest.setValue(apiKey, forHTTPHeaderField: "WEB-API-key")
            urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
            
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
