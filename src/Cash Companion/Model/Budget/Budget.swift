//
//  Budget.swift
//  Cash Companion
//
//  Created by Niklas Pernter on 13.07.2023.
//

import Foundation
import SwiftData

class SelectedBudget: ObservableObject {
    @Published var budget: Budget?
}


@Model
final class Budget {
    
    @Attribute(.unique) let name: String
    let startDate: Date
    let endDate: Date
    let amount: Double
    
    @Relationship(.cascade)
    var transactions: [Transaction] = []
    
    init(name: String = "", startDate: Date = .now, endDate: Date = .now, amount: Double = 0.0) {
        self.name = name;
        self.startDate = startDate;
        self.endDate = endDate;
        self.amount = amount;
    }
    
    public func getNetto() -> Double {
        return self.amount + self.transactions.reduce(0, {$0 + $1.amount})
    }
    
    public func getRemainingDays() -> Int {
        let calendar = Calendar.current
        let totalDays = calendar.dateComponents([.day], from: startDate, to: endDate).day! + 1
        let passedDays = calendar.dateComponents([.day], from: startDate, to: Date()).day!
        return totalDays - passedDays
    }
    
    public func getDuration() -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: startDate, to: endDate)
        // The duration should be at least one day, hence adding 1
        return components.day! + 1
    }
    
    public func getDailyBrutto() -> Double {
        return amount / Double(getDuration())
    }
    
    public func getTransactionsValue() -> Double {
        return transactions.reduce(0, {$0 + $1.amount})
    }
    
}

extension Budget {
    static var dummy: Budget {
        .init(name: "Budget 1", startDate: .now, endDate: .now, amount: 1000.0)
    }
    
}
