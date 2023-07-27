//
//  SwiftDataAppContainer.swift
//  Cash Companion
//
//  Created by Niklas Pernter on 22.07.2023.
//

import Foundation
import SwiftUI
import SwiftData

let transactionCategories: [Category] = [
    Category(name: "Income"),
    Category(name: "Groceries"),
    Category(name: "Rent"),
    Category(name: "Utilities"),
    Category(name: "Restaurants"),
    Category(name: "Transportation"),
    Category(name: "Healthcare"),
    Category(name: "Entertainment"),
    Category(name: "Shopping"),
    Category(name: "Travel"),
    Category(name: "Savings"),
    Category(name: "Investments"),
    Category(name: "Taxes"),
    Category(name: "Insurance"),
    Category(name: "Debt"),
    Category(name: "Education"),
    Category(name: "Miscellaneous")
]

let bankAccounts: [Account] = [
    Account(name: "Bank", initialAmount: 1000.0),
    Account(name: "Savings", initialAmount: 1000.0),
    Account(name: "Tax", initialAmount: 500.0)

]


let budgets: [Budget] = [
    .dummy
]

@MainActor
func createAppContainer(useInMemory: Bool = false) -> ModelContainer {
    do {
        
        let container = try ModelContainer(
                    for: [Budget.self, Transaction.self, Category.self, Account.self],
                    ModelConfiguration(inMemory: useInMemory)
                )
        if(!hasDefaultCategories(container: container)) {
            for category in transactionCategories {
                container.mainContext.insert(object: category)
            }
        }
        if(!hasDefaultBankAccounts(container: container)) {
            for bankAccount in bankAccounts {
                container.mainContext.insert(object: bankAccount)
            }
        }
        if(hasDefaultBudget(container: container)) {
            for budget in budgets {
                container.mainContext.insert(object: budget)
            }
        }

        return container
    } catch {
        fatalError("Failed to create container")
    }
}

@MainActor func hasDefaultCategories(container: ModelContainer) -> Bool {
    let itemFetchDescriptor = FetchDescriptor<Category>()
    do {
        return try container.mainContext.fetch(itemFetchDescriptor).count == transactionCategories.count
    } catch {
        return false
    }
}

@MainActor func hasDefaultBankAccounts(container: ModelContainer) -> Bool {
    let itemFetchDescriptor = FetchDescriptor<Account>()
    do {
        return try container.mainContext.fetch(itemFetchDescriptor).count == bankAccounts.count
    } catch {
        return false
    }
}

@MainActor func hasDefaultBudget(container: ModelContainer) -> Bool {
    let itemFetchDescriptor = FetchDescriptor<Budget>()
    do {
        return try container.mainContext.fetch(itemFetchDescriptor).count == 0
    } catch {
        return false
    }
}

@MainActor
let appContainer = createAppContainer()

@MainActor
let appContainerInMemory = createAppContainer(useInMemory: true)
