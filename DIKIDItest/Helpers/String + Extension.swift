//
//  String + Extension.swift
//  DIKIDItest
//
//  Created by Владислав Соколов on 07.04.2025.
//

import Foundation

extension Formatter {
    static let currencyGrouped: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.groupingSeparator = " "
        formatter.decimalSeparator = "."
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
}

extension String {
    var formattedAsCurrency: String {
        guard let number = Double(self) else { return self }
        return Formatter.currencyGrouped.string(from: NSNumber(value: number)).map { "\($0) ₽" } ?? self
    }
}
