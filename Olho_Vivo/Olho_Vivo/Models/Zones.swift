//
//  Zones.swift
//  Olho_Vivo
//
//  Created by Dayô Araújo on 27/11/26.
//

import Foundation
import SwiftUI

enum Zones: String, CaseIterable {
    case noroeste
    case norte
    case nordeste
    case leste
    case sudeste
    case sul
    case sudoeste
    case oeste
    case central
    
    var name: String {
        return self.rawValue.capitalized
    }
    
    var number: Int {
        switch self {
        case .noroeste:
            return 1
        case .norte:
            return 2
        case .nordeste:
            return 3
        case .leste:
            return 4
        case .sudeste:
            return 5
        case .sul:
            return 6
        case .sudoeste:
            return 7
        case .oeste:
            return 8
        case .central:
            return 9
        }
    }
    
    var color: Color {
        switch self {
        case .noroeste:
            return .lightGreen
        case .norte:
            return .darkBlue
        case .nordeste:
            return .lightYellow
        case .leste:
            return .lightRed
        case .sudeste:
            return .darkGreen
        case .sul:
            return .lightBlue
        case .sudoeste:
            return .darkRed
        case .oeste:
            return .darkYellow
        case .central:
            return .lightGrey
        }
    }
}
