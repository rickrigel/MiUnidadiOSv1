//
//  LoginModel.swift
//  UnidadesHabitacionales
//
//  Created by Ricardo Sanchez on 27/10/24.
//

import Foundation

struct UserModel: Codable {
    let name: String
    let apartment: String
    let unit: String
    let isAdmin: Bool
}
