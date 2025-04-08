//
//  Employees.swift
//  DIKIDItest
//
//  Created by Владислав Соколов on 07.04.2025.
//

import Foundation

struct ApiResponceEmployee: Decodable, Hashable {
    let record: MainEmployee
}

struct MainEmployee: Decodable, Hashable {
    let data: DataClass
}

struct DataClass: Decodable, Hashable {
    let list: [MainList]
}

struct MainList: Decodable, Hashable {
    let employee: Employee
    let payrollBalanceBegin: String
    let overpaymentBegin: String?
    let payrollBalanceEnd: String
    let overpaymentEnd: String?
    let payroll, deduction, paid, payable: String
    let balance: String

    enum CodingKeys: String, CodingKey {
        case employee
        case payrollBalanceBegin = "payroll_balance_begin"
        case overpaymentBegin = "overpayment_begin"
        case payrollBalanceEnd = "payroll_balance_end"
        case overpaymentEnd = "overpayment_end"
        case payroll, deduction, paid, payable, balance
    }
}

struct Employee: Decodable, Hashable {
    let id: String
    let icon: String
    let fullname, statusID: String
    let statusTitle: StatusTitle
    let categoryID, categoryTitle: String
    let salarySchemeID: String?

    enum CodingKeys: String, CodingKey {
        case id, icon, fullname
        case statusID = "status_id"
        case statusTitle = "status_title"
        case categoryID = "category_id"
        case categoryTitle = "category_title"
        case salarySchemeID = "salary_scheme_id"
    }
}

enum StatusTitle: String, Decodable, Hashable {
    case активен = "Активен"
}

