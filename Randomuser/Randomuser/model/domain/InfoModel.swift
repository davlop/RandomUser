//
//  InfoModel.swift
//  Randomuser
//
//  Created by David Lopez on 21/9/22.
//

import Foundation

struct InfoModel: Decodable {
    var seed: String = ""
    var results: Int = 0
    var page: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case seed = "seed"
        case results = "results"
        case page = "page"
    }
}
