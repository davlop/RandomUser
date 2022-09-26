//
//  StandardNetworkService.swift
//  Randomuser
//
//  Created by David Lopez on 21/9/22.
//

import Foundation

// MARK: Protocol
protocol NetworkService {
    var session: URLSession { get set }
    var urlRequest: URLRequestProtocol { get set }
    
    func get<Resource: Decodable>(headers: [String: String], completion: @escaping (Result<[Resource], Error>) -> Void)
    // add other HTTP methods as needed
}

// MARK: Implementation
struct StandardNetworkService: NetworkService {
    var session: URLSession
    var urlRequest: URLRequestProtocol
    
    init(session: URLSession = URLSession.shared, urlRequest: URLRequestProtocol) {
        self.session = session
        self.urlRequest = urlRequest
    }
    
    init(path: String, queryItems: [URLQueryItem]? = nil) {
        let endpoint = StandardEndpoint(path: path, queryItems: queryItems)
        self.init(urlRequest: StandardURLRequest(endpoint: endpoint))
    }
}

extension NetworkService {
    func get<Resource: Decodable>(headers: [String: String], completion: @escaping (Result<Resource, Error>) -> Void) {
        var request = urlRequest.makeURLRequest(headers: headers)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let data = data, data.isEmpty == false else {
                completion(.failure(NetworkError.emptyResponse))
                return
            }
            
            do {
                let resources = try JSONDecoder().decode(Resource.self, from: data)
                completion(.success(resources))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

