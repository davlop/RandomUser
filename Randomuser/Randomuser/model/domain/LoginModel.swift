//
//  LoginModel.swift
//  Randomuser
//
//  Created by David Lopez on 26/9/22.
//

import Foundation

struct LoginModel: Decodable {
    var username: String = ""
    var password: String = ""
    
    enum CodingKeys: String, CodingKey {
        case username = "username"
        case password = "password"
    }
}
