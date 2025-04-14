//
//  MainViewModel.swift
//  DIKIDItest
//
//  Created by Владислав Соколов on 06.04.2025.
//

import SwiftUI

@Observable
final class MainViewModel {
    var balance: Balance? = nil
    var employee: [MainList] = []
    var error: NetworkError?
    
    private let employeeKey = "cachedEmployees"
    private let balanceKey = "cachedBalance"
    
    private let networkManager: ServerApi
    private let storage: StorageService
    
    init(networkManager: ServerApi, storage: StorageService) {
        self.networkManager = networkManager
        self.storage = storage
    }
    
    func loadCachedData() {
        self.balance = try? storage.load(Balance.self, for: balanceKey)
        self.employee = (try? storage.load([MainList].self, for: employeeKey)) ?? []
    }
    
    func fetchBalance() async {
        do {
            let responce = try await networkManager.fetch(type: ApiResponceBalance.self, from: Dashboard())
            self.balance = responce.record.data
            storage.save(responce.record.data, for: balanceKey)
        } catch let error as NetworkError {
            self.error = error
            self.balance = try? storage.load(Balance.self, for: balanceKey)
        } catch {
            self.error = .unknownError(0)
        }
    }
    
    func fetchEmployee() async {
        do {
            let responce = try await networkManager.fetch(type: ApiResponceEmployee.self, from: EmployeeList())
            self.employee = responce.record.data.list
            storage.save(responce.record.data.list, for: employeeKey)
        } catch let error as NetworkError {
            self.error = error
            self.employee = (try? storage.load([MainList].self, for: employeeKey)) ?? []
        } catch {
            self.error = .unknownError(0)
        }
    }
}


