//
//  TransitViewModel.swift
//  Olho_Vivo
//
//  Created by Dayô Araújo on 27/11/26.
//

import Foundation

@Observable
class TransitViewModel {
    private let api = Service()
    
    private(set) var isAuthenticated = false
    private(set) var lines: [Line] = []
    private(set) var stopsByLine: [Int: [Stop]] = [:]
    private(set) var buses: [Bus] = []
    
    var selectedLine: Line?
    
    var currentStops: [Stop] {
        guard let code = selectedLine?.codigo else { return [] }
        return stopsByLine[code] ?? []
    }
    
    var busCount: Int { buses.count }
    
    func stopCount(for line: Line) -> Int {
        stopsByLine[line.codigo]?.count ?? 0
    }

    func authenticate(key: String) async throws {
        isAuthenticated = try await api.auth(key: key)
    }

    func searchLines(query: String) async throws {
        (lines, stopsByLine) = try await api.fetchLine(line: query)
    }

    func selectLine(_ line: Line) async throws {
        selectedLine = line
        let response = try await api.fetchBus(codLine: String(line.codigo))
        buses = response.onibus
    }

    func clearData() {
        lines.removeAll()
        stopsByLine.removeAll()
        buses.removeAll()
        selectedLine = nil
    }
}
