//
//  NetworkError.swift
//  DIKIDItest
//
//  Created by Владислав Соколов on 06.04.2025.
//

import Foundation

enum NetworkError: Error, Equatable {
    case invalidUrl
    case invalidResponse
    case decodingFailed
    case clientError(Int)
    case serverError(Int)
    case unknownError(Int)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidUrl:
            "Invalid url"
        case .invalidResponse:
            "Invalid response received from the server."
        case .decodingFailed:
            "Failed to decode the response data."
        case .clientError(let statusCode):
            "Client error occurred. Status code: \(statusCode)"
        case .serverError(let statusCode):
            "Server error occurred. Status code: \(statusCode)"
        case .unknownError(let statusCode):
            "An unknown error occurred. Status code: \(statusCode)"
        }
    }
}
