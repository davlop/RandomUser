//
//  URLRequest.swift
//  Randomuser
//
//  Created by David Lopez on 21/9/22.
//

import Foundation

// MARK: Protocol
protocol URLRequestProtocol {
    func makeURLRequest(headers: [String: String]) -> URLRequest
    var endpoint: Endpoint { get set }
}

// MARK: Implementation
struct StandardURLRequest: URLRequestProtocol {
    var endpoint: Endpoint
    
    func makeURLRequest(headers: [String: String]) -> URLRequest {
        guard let url = endpoint.url else {
            fatalError("Unable to make url request")
        }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        return request
    }
}
