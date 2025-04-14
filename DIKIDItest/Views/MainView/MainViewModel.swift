//
//  MainViewModel.swift
//  DIKIDItest
//
//  Created by Владислав Соколов on 06.04.2025.
//

import Foundation

@MainActor
final class MainViewModel: ObservableObject {
    @Published var balance: Balance? = nil
    @Published var employee: [MainList] = []
    
    private let networkManager: ServerApi
    
    init(networkManager: ServerApi) {
        self.networkManager = networkManager
    }
    
    func fetchBalance() async {
        do {
            let responce = try await networkManager.fetch(type: ApiResponceBalance.self, from: Dashboard())
            self.balance = responce.record.data
        } catch {
            print("Ошибка загрузки - \(error)")
        }
    }
    
    func fetchEmployee() async {
        do {
            let responce = try await networkManager.fetch(type: ApiResponceEmployee.self, from: EmployeeList())
            self.employee = responce.record.data.list
        } catch {
            self.error = .unknownError(0)
        }
    }
}


