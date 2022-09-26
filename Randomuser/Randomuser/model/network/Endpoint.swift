//
//  Endpoint.swift
//  Randomuser
//
//  Created by David Lopez on 21/9/22.
//

import Foundation

// MARK: Protocol
protocol Endpoint {
    var path: String { get set }
    var queryItems: [URLQueryItem]? { get set }
    var scheme: String? { get }
    var url: URL? { get }
}

// MARK: Implementation
struct StandardEndpoint: Endpoint {
    var path: String
    var queryItems: [URLQueryItem]? = nil
    var scheme: String? = "https"
    var url: URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
    
    init(path: String, queryItems: [URLQueryItem]?) {
        self.path = path
        self.queryItems = queryItems
    }
}
