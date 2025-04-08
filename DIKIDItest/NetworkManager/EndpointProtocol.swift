//
//  EndpointProtocol.swift
//  DIKIDItest
//
//  Created by Владислав Соколов on 06.04.2025.
//

import Foundation

protocol EndpointProtocol {
    var url: URL { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
}

extension EndpointProtocol {
    var method: HTTPMethod {
        .get
    }
    
    var headers: [String: String]? {
        ["accept": "application/json",
         "X-Access-Key": "$2a$10$m6NJ1xlOauQN6ZFNY/I/ben/8TQ.HyryPA1fMWDxLlJi2y5XM0xiu"]
    }
    
    func urlRequest() throws -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        return request
    }
}
