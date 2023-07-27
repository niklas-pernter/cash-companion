//
//  ArrayExtensions.swift
//  Cash Companion
//
//  Created by Niklas Pernter on 26.07.2023.
//

import Foundation
import SwiftUI

extension Array where Element: Equatable {
    // Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        guard let index = firstIndex(of: object) else {return}
        remove(at: index)
    }
    
}

extension Array where Element: Transaction {
    var sortedTransactions: [Transaction] {
        return self.sorted(by: { $0.createdAt > $1.createdAt })
    }
    
    var summed: Double {
        return self.reduce(0, { $0 + $1.amount})
    }
    
    func byDate(date: Date) -> [Transaction] {
        return self.filter { transaction in
            return Calendar.current.isDate(date, inSameDayAs: transaction.createdAt)
        }
    }
}

