//
//  Category.swift
//  Cash Companion
//
//  Created by Niklas Pernter on 21.07.2023.
//

import Foundation
import SwiftData

@Model
final class Category {
    @Attribute(.unique) var name: String
    
    init(name: String) {
        self.name = name
    }
   
}
