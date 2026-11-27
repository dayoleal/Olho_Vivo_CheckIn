//
//  Stop.swift
//  Olho_Vivo
//
//  Created by Dayô Araújo on 27/11/26.
//

struct Stop: Codable, Identifiable {
    let codigo: Int
    let nome: String
    let endereco: String
    let latitute: Double
    let longitude: Double
    
    var id: Int { codigo } 
    
    enum CodingKeys: String, CodingKey {
        case codigo = "cp"
        case nome = "np"
        case endereco = "ed"
        case latitute = "py"
        case longitude = "px"
    }
}
