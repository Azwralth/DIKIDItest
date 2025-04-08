//
//  Endpoints.swift
//  DIKIDItest
//
//  Created by Владислав Соколов on 06.04.2025.
//

import Foundation

struct Dashboard: EndpointProtocol {
    var url: URL {
        return URL(string: "https://api.jsonbin.io/v3/b/67f256638561e97a50f9a499")!
    }
}

struct EmployeeList: EndpointProtocol {
    var url: URL {
        return URL(string: "https://api.jsonbin.io/v3/b/67f3ec0d8a456b7966842e3d")!
    }
}
