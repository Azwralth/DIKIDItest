//
//  ServerApi.swift
//  DIKIDItest
//
//  Created by Владислав Соколов on 06.04.2025.
//

import SwiftUI

protocol ServerApi {
    func fetch<T: Decodable>(type: T.Type, from endpoint: EndpointProtocol) async throws -> T
}


final class NetworkManager: ServerApi {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetch<T: Decodable>(type: T.Type, from endpoint: EndpointProtocol) async throws -> T {
        let request = try endpoint.urlRequest()
        let (data, response) = try await session.data(for: request)
        
        guard response is HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
                
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}
