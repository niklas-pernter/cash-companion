//
//  Util.swift
//  Cash Companion
//
//  Created by Niklas Pernter on 17.07.2023.
//

import Foundation
import SwiftUI
import SwiftData


class Util {
    
    func isInsideBudgetDate(start: Date, end: Date) -> Bool {
        let calendar = Calendar.current
        let currentDate = Date()
        
        let startDay = calendar.startOfDay(for: start)
        let endDay = calendar.startOfDay(for: end)
        let currentDay = calendar.startOfDay(for: currentDate)
        
        return currentDay >= startDay && currentDay <= endDay
    }
    
    
    func calculateRemainingDailyBudget(budget: Budget, distribute: Bool) -> Double? {
        let calendar = Calendar.current
        let totalDays = calendar.dateComponents([.day], from: budget.startDate, to: budget.endDate).day! + 1
        let dailyBudget = budget.amount / Double(totalDays)
        var nettoDailyBudget = 0.0
        let passedDays = calendar.dateComponents([.day], from: budget.startDate, to: Date()).day!
        var remainingDays = totalDays - passedDays
        
        if distribute {
            nettoDailyBudget = budget.getNetto() / Double(passedDays)
            return nettoDailyBudget
        } else {
            for i in 0...passedDays {
                let transactionsOfDay = getTransactionsOfDay(budget: budget, day: i)
                let transactionsValue = transactionsOfDay.reduce(0, {$0 + $1.amount})
                nettoDailyBudget += transactionsValue + dailyBudget
            }
            return nettoDailyBudget
        }
        
        
        
    }
    
    func getTransactionsOfDay(budget: Budget, day: Int) -> [Transaction] {
        var dateComponent = DateComponents()
        dateComponent.day = day
        let dateOfPassedDay = Calendar.current.date(byAdding: dateComponent, to: budget.startDate)!
        return budget.transactions.filter { transaction in
            return Calendar.current.isDate(dateOfPassedDay, equalTo: transaction.timestamp, toGranularity: .day)
        }
    }
    
    
    
}


extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

extension Array where Element: Equatable {
    
    // Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        guard let index = firstIndex(of: object) else {return}
        remove(at: index)
    }
    
}
