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

    @Attribute(.unique) var title: String
    let timestamp: Date
    let amount: Double

    
    init(title: String = "", timestamp: Date = .now, amount: Double = 0) {
        self.title = title
        self.timestamp = timestamp
        self.amount = amount
    }
}

extension Transaction {
    
    static var dummy: Transaction {
        .init(title: "Transaction 1",
              timestamp: .now,
              amount: 0.0)
    }
    

}
