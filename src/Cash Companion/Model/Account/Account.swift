//
//  BankAccount.swift
//  Cash Companion
//
//  Created by Niklas Pernter on 25.07.2023.
//

import Foundation
import SwiftData

@Model
final class Account {

    let name: String
    var initialAmount: Double
    
    @Relationship(.cascade)
    var transactions: [Transaction] = []
    
    @Relationship(.cascade)
    var budgets: [Budget] = []

    
    init(name: String, initialAmount: Double) {
        self.name = name
        self.initialAmount = initialAmount
    }

    var nettoAmount: Double {
        return self.initialAmount + self.transactions.reduce(0, {$0 + $1.amount})
    }
}


extension Account {
    static var dummy: Account {
        .init(name: "Bank", initialAmount: 1000.0)
    }
}
