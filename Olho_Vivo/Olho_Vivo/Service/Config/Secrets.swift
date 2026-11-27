//
//  Secrets.swift
//  Olho_Vivo
//
//  Created by Dayô Araújo on 27/11/26.
//

import Foundation

/// Return token from info.plist
enum Secrets {
    static var accessToken: String {
        guard let token = Bundle.main.object(forInfoDictionaryKey: "access_token") as? String, !token.isEmpty else {
            fatalError("[ERROR]: access_token not found Info.plist")
        }
        return token
    }
}
