//
//  LocationModel.swift
//  Randomuser
//
//  Created by David Lopez on 26/9/22.
//

import Foundation

struct LocationModel: Decodable {
    var country: String = ""
    
    enum CodingKeys: String, CodingKey {
        case country = "country"
    }
}
