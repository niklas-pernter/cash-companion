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
    
    func addDaysToDate(date: Date = Date(), days: Int) -> Date {
        var dateComponent = DateComponents()
        dateComponent.day = days
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: date)!
        return futureDate
    }
    
    func calculateRemainingDailyBudget(budget: Budget, distribute: Bool, customDateEnd: Date = Date()) -> Double? {
        print("customDate", customDateEnd.toString())
        let calendar = Calendar.current
        let totalDays = Calendar.current.numberOfDaysBetween(budget.startDate, and: budget.endDate)
        let dailyBudget = budget.amount / Double(totalDays)
        print("totalDays", totalDays)
        print("budget.amount", budget.amount)

        var nettoDailyBudget = 0.0
        let passedDays = Calendar.current.numberOfDaysBetween(budget.startDate, and: customDateEnd)
        let remainingDays = totalDays - passedDays
        
        print("dailyBudget", dailyBudget)
        print("passedDays", passedDays)
        print("remainingDays", remainingDays)

        var surplus = 0.0
        if distribute {
            nettoDailyBudget = budget.getNetto() / Double(remainingDays)
            print("netto daily", nettoDailyBudget)
            return nettoDailyBudget
        } else {
            for i in 1...passedDays {
                print("day " + String(i))
                let transactionsOfDay = getTransactionsOfDay(budget: budget, day: i)
                print("transactionsOfDay", transactionsOfDay)

                let transactionsValue = transactionsOfDay.reduce(0, {$0 + $1.amount})
                print("transactionsValue", transactionsValue)
                print("dailyBudget", dailyBudget)
                surplus += transactionsValue + dailyBudget
                print("surplus", surplus)
                nettoDailyBudget += transactionsValue + dailyBudget
                print("nettoDailyBudget", nettoDailyBudget)

            }
            return nettoDailyBudget
        }
    }
    
    func getTransactionsOfDay(budget: Budget, day: Int) -> [Transaction] {
        let futureDate = addDaysToDate(date: budget.startDate, days: day)
        return budget.transactions.filter { transaction in
            return Calendar.current.isDate(futureDate, inSameDayAs: transaction.timestamp)        }
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

extension Date {
        func toString() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.setLocalizedDateFormatFromTemplate("d MMMM yyyy")
            return dateFormatter.string(from: self)
        }
    
    func addDays(days: Int) -> Date {
        var dateComponent = DateComponents()
        dateComponent.day = days
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: self)!
        return futureDate
    }
}

extension Calendar {
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
        let fromDate = startOfDay(for: from) // <1>
        let toDate = startOfDay(for: to) // <2>
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate) // <3>
        
        return numberOfDays.day!
    }
}
