//
//  Goal.swift
//  Cash Companion
//
//  Created by Niklas Pernter on 28.07.2023.
//

import Foundation
import SwiftData

@Model
final class Goal {
    let name: String
    let amount: Double
    let picture: String
    
    @Relationship(.nullify)
    var transactions: [Transaction] = []
    
    init(name: String, amount: Double, picture: String) {
        self.name = name
        self.amount = amount
        self.picture = picture
    }
}
