//
//  Service.swift
//  Olho_Vivo
//
//  Created by Dayô Araújo on 27/11/26.
//

import Foundation

class Service {
    private var session = URLSession.self
    private var decoder = JSONDecoder()
    private var base: String = "https://api.olhovivo.sptrans.com.br/v2.1/"
    
    func auth(key: String) async throws -> Bool {
        let endPoint = base + "Login/Autenticar?token=" + key
                    
        guard let url = URL(string: endPoint) else {
            throw APIErrors.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = Data()
        
        let (data, response) = try await session.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIErrors.decodingError
        }

        guard httpResponse.statusCode == 200 else {
            if let body = String(data: data, encoding: .utf8) {
            }
            throw APIErrors.decodingError
        }
        
        let success = try decoder.decode(Bool.self, from: data)
        
        guard success else {
            throw APIErrors.decodingError
        }
        return true
    }
}

enum APIErrors: String, Error {
    case invalidURL
    case networkError
    case decodingError
    case apiError
}
