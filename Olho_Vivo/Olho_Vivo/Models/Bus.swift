//
//  Bus.swift
//  Olho_Vivo
//
//  Created by Dayô Araújo on 27/11/26.
//

import Foundation
import SwiftUI

struct Bus: Codable, Identifiable {
    let prefixo: String
    let acessivel: Bool
    let horario: String
    let latitude: Double
    let longitude: Double
    
    var cor: Color {
        guard let number = prefixo.first?.wholeNumberValue,
              let zone = Zones.allCases.first(where: { $0.number == number }) else {
            return .gray
        }
        return zone.color
    }
    var id: Int { Int(prefixo) ?? 0 }
    
    enum CodingKeys: String, CodingKey {
        case prefixo = "p"
        case acessivel = "a"
        case horario = "ta"
        case latitude = "py"
        case longitude = "px"
    }
}
