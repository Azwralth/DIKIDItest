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
}
