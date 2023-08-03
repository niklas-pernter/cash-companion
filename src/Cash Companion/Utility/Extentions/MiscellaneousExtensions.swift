//
//  MiscellaneousExtensions.swift
//  Cash Companion
//
//  Created by Niklas Pernter on 26.07.2023.
//

import Foundation
import SwiftUI

extension NumberFormatter {
    
    static var dollarNumberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        return formatter
    }
}
extension Double {
    func asCurrency(withSymbol symbol: String = "$") -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = symbol
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }

    func toCents() -> Int {
        return Int(self*100)
    }
    
    func toString() -> String {
        return String(self)
    }
}

extension Int {
    func toDollars() -> Double {
        return Double(self/100)
    }
    
    func toString() -> String {
        return String(self)
    }
}

extension String {
    func formatToDays() -> String {
        return self + " Days"
    }
}
