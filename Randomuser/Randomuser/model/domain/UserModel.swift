//
//  User.swift
//  Randomuser
//
//  Created by David Lopez on 19/9/22.
//

import Foundation

struct UserModel: Decodable {
    var name: UserNameModel = UserNameModel()
    var picture: PictureModel = PictureModel()
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case picture = "picture"
    }
}
