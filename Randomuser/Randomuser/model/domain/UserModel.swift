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
    var location: LocationModel = LocationModel()
    var email: String = ""
    var phone: String = ""
    var dob: DateOfBirthModel = DateOfBirthModel()
    var gender: String = ""
    var login: LoginModel = LoginModel()
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case picture = "picture"
        case location = "location"
        case email = "email"
        case phone = "phone"
        case dob = "dob"
        case gender = "gender"
        case login = "login"
    }
}
