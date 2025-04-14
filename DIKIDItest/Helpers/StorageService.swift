//
//  StorageService.swift
//  DIKIDItest
//
//  Created by Владислав Соколов on 14.04.2025.
//

import Foundation

protocol StorageService {
    func save<T: Encodable>(_ value: T, for key: String)
    func load<T: Decodable>(_ type: T.Type, for key: String) throws -> T?
}

final class UserDefaultsStorageService: StorageService {
    private let defaults = UserDefaults.standard
    
    func save<T: Encodable>(_ value: T, for key: String) {
        if let data = try? JSONEncoder().encode(value) {
            defaults.set(data, forKey: key)
        }
    }
    
    func load<T: Decodable>(_ type: T.Type, for key: String) throws -> T? {
        guard let data = defaults.data(forKey: key) else { return nil }
        return try? JSONDecoder().decode(type, from: data)
    }
}
