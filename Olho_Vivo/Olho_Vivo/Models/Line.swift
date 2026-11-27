//
//  Line.swift
//  Olho_Vivo
//
//  Created by Dayô Araújo on 27/11/26.
//

import Foundation
import SwiftUI

struct Line: Codable, Identifiable {
    let codigo: Int
    let circular: Bool
    let letreiro: String
    let sentido: Int
    let tipo: Int
    let destino: String
    let origem: String
    
    var cor: Color {
        guard let number = letreiro.first?.wholeNumberValue,
              let zone = Zones.allCases.first(where: { $0.number == number }) else {
            return .gray
        }
        return zone.color
    }
    var id: Int { codigo }

    enum CodingKeys: String, CodingKey {
        case codigo = "cl"
        case circular = "lc"
        case letreiro = "lt"
        case sentido = "sl"
        case tipo = "tl"
        case destino = "tp"
        case origem = "ts"
    }
}
