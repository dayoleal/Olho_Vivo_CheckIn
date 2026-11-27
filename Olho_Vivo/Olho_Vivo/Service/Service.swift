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
    
    // Authentication
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
    
    private func request<T: Decodable>(_ endpoint: String, context: String) async throws -> T {
        guard let url = URL(string: endpoint) else {
            throw APIErrors.invalidURL
        }

        let (data, response) = try await session.shared.data(for: URLRequest(url: url))

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIErrors.networkError
        }

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw APIErrors.decodingError
        }
    }

    func fetchLine(line: String) async throws -> ([Line], [Int: [Stop]]) {
        let codedTerm = line.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? line
        let lines: [Line] = try await request(
            base + "Linha/Buscar?termosBusca=\(codedTerm)",
            context: "linha"
        )

        guard !lines.isEmpty else {
            return ([], [:])
        }

        let stopsPerLine = try await populate(lines: lines)
        return (lines, stopsPerLine)
    }

    private func populate(lines: [Line]) async throws -> [Int: [Stop]] {
        var dictionary: [Int: [Stop]] = [:]

        for line in lines {
            dictionary[line.codigo] = try await fetchStops(codLine: String(line.codigo))
        }

        return dictionary
    }

    private func fetchStops(codLine: String) async throws -> [Stop] {
        try await request(
            base + "Parada/BuscarParadasPorLinha?codigoLinha=\(codLine)",
            context: "parada com cod: \(codLine)"
        )
    }

    func fetchBus(codLine: String) async throws -> BusDisplay {
        try await request(
            base + "Posicao/Linha?codigoLinha=\(codLine)",
            context: "onibus com codLinha: \(codLine)"
        )
    }
}

enum APIErrors: String, Error {
    case invalidURL
    case networkError
    case decodingError
    case apiError
}
