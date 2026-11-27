//
//  BusDisplay.swift
//  Olho_Vivo
//
//  Created by Dayô Araújo on 27/11/26.
//

import Foundation

struct BusDisplay: Codable {
    let horario: String
    let onibus: [Bus]
    
    enum CodingKeys: String, CodingKey {
        case horario = "hr"
        case onibus = "vs"
    }
}
