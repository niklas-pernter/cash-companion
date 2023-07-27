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
public final class Budget: NettoCalculatable {
    let name: String
    let createdAt: Date
    let startDate: Date
    let endDate: Date
    let amount: Double

    @Relationship(.cascade)
    var transactions: [Transaction] = []
    
    init(name: String = "", startDate: Date = .now, endDate: Date = .now, amount: Double = 0.0) {
        self.createdAt = .now
        self.name = name;
        self.startDate = startDate;
        self.endDate = endDate;
        self.amount = amount;
    }
    
    var nettoAmount: Double {
        return self.amount + self.transactions.reduce(0, {$0 + $1.amount})
    }
    
    
}

extension Budget {
    static var dummy: Budget {
        .init(name: "Budget 1", startDate: .now, endDate: .now.addDays(days: 10), amount: 1000.0)
    }
    
    func calculateDailyBudget(distribute: Bool = false, customCurrentDate: Date = Date()) -> Double {
        if self.getRemainingDays() == nil {
            return 0.0
        }
        
        let totalDays = Calendar.current.numberOfDaysBetween(self.startDate, and: self.endDate)
        print("total days function: ", totalDays)
        let dailyBudget = self.amount / Double(totalDays)
        print("dailyBudget function: ", dailyBudget)

        
        let passedDays = Calendar.current.numberOfDaysBetween(self.startDate, and: customCurrentDate)
        print("passedDays function: ", passedDays)

        let remainingDays = totalDays - passedDays + 1

        if distribute {
            return (self.nettoAmount / Double(remainingDays)).isInfinite ? 0.0 : self.nettoAmount / Double(remainingDays)
        } else {
            let nettoDailyBudget = (1...passedDays).reduce(0.0) { (result, i) -> Double in
                
                let transactionsOfDay = transactions.byDate(date: self.startDate.addDays(days: i))
                let transactionsValue = transactionsOfDay.reduce(0, {$0 + $1.amount})
                return result + transactionsValue + dailyBudget
            }
            return nettoDailyBudget
        }
    }

    
    public func getRemainingDays() -> Int? {
        let calendar = Calendar.current
        let remainingDays = calendar.numberOfDaysBetween(self.startDate, and: self.endDate) -
        calendar.numberOfDaysBetween(self.startDate, and: Date()) + 1
        return remainingDays >= 0 ? remainingDays : nil
    }


    
    public func getNettoUntil(date: Date) -> Double {
        return self.amount + self.transactions.filter{ transaction in
            transaction.createdAt <= date
        }.reduce(0, {$0 + $1.amount})
    }

    
}
