//
//  MainBalance.swift
//  DIKIDItest
//
//  Created by Владислав Соколов on 07.04.2025.
//

import Foundation

struct ApiResponceBalance: Codable {
    let record: MainBalance
}

struct MainBalance: Codable {
    let data: Balance
}

struct Balance: Codable {
    let payrollBalanceBegin: String
    let overpaymentBegin: String?
    let payrollBalanceEnd: String
    let overpaymentEnd: String?
    let payroll: String
    let deduction: String
    let paid: String
    let balance: String
    let payable: String?
}
