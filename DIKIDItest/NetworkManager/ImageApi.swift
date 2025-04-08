//
//  ImageApi.swift
//  DIKIDItest
//
//  Created by Владислав Соколов on 07.04.2025.
//

import Foundation

protocol ImageApi {
    func fetchImage(from url: URL) async throws -> Data
}

final class NetworkImageManager: ImageApi {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchImage(from url: URL) async throws -> Data {
        let (data, response) = try await session.data(for: URLRequest(url: url))
        
        guard response is HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        return data
    }
    
}
