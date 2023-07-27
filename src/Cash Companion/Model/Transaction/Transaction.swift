//
//  Transaction.swift
//  Cash Companion
//
//  Created by Niklas Pernter on 04.07.2023.
//

import Foundation
import SwiftData

@Model
final class Transaction {
    var name: String?
    let createdAt: Date
    let amount: Double
    @Relationship(.nullify)
    var category: Category?
    
    init(name: String? = nil, createdAt: Date = .now, amount: Double = 0) {
        self.name = name
        self.createdAt = createdAt
        self.amount = amount
    }
      
    
    
}

extension Transaction {
    
    static var dummy: Transaction {
        .init(name: "Transaction 1",
              createdAt: .now,
              amount: 0.0)
    }
    

}
