//
//  ResponseModel.swift
//  Randomuser
//
//  Created by David Lopez on 21/9/22.
//

import Foundation

struct ResponseModel: Decodable {
    var results: [UserModel] = []
    var info: InfoModel
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
        case info = "info"
    }
}
