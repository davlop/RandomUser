//
//  UserNameModel.swift
//  Randomuser
//
//  Created by David Lopez on 21/9/22.
//

import Foundation

struct UserNameModel: Decodable {
    var firstName: String = ""
    var lastName: String = ""
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first"
        case lastName = "last"
    }
}
