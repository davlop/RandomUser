//
//  PictureModel.swift
//  Randomuser
//
//  Created by David Lopez on 23/9/22.
//

import Foundation

struct PictureModel: Decodable {
    var large: String = ""
    
    enum CodingKeys: String, CodingKey {
        case large = "large"
    }
}
