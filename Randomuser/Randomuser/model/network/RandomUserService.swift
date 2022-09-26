//
//  RandomUserService.swift
//  Randomuser
//
//  Created by David Lopez on 21/9/22.
//

import Foundation
import CoreLocation

final class RandomUserService {
    static let headers: [String: String] = ["Content-Type": "application/json", "Accept": "application/json"]

    var networkService: StandardNetworkService?
    
    func fetchRandomUsersPage(page: Int, seed: String?, completion: @escaping (Result<ResponseModel, Error>) -> Void) {
        var queryItems: [URLQueryItem] = [URLQueryItem(name: "results", value: "32")]
        if let seed = seed {
            queryItems.append(URLQueryItem(name: "seed", value: seed))
        }
        queryItems.append(URLQueryItem(name: "page", value: "\(page)"))
        networkService = StandardNetworkService(path: "randomuser.me/api", queryItems: queryItems)
        networkService?.get(headers: RandomUserService.headers, completion: completion)
    }
}
