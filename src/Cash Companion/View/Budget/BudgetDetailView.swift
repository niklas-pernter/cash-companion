//
//  BudgetDetailView.swift
//  Cash Companion
//
//  Created by Niklas Pernter on 13.07.2023.
//

import SwiftUI
import SwiftData
import Charts

struct BudgetDetailView: View {
    @Bindable var budget: Budget
    var isPreview: Bool = false
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var showCreateTransaction = false
    
    var body: some View {
        let sortedTransactions = budget.transactions.sortedTransactions
        
        List {
            TransactionSection(title: "Transactions", transactions: budget.transactions, onDelete: { transaction in
                budget.transactions.remove(object: transaction)
            }).withAnalytics()
        }
        .navigationTitle(budget.name)
        .safeAreaInset(edge: .bottom,
                       alignment: .leading) {
            Button(action: {
                showCreateTransaction = true
            }, label: {
                FabActionButton(labelTitel: "New Transaction")
            }).sheet(isPresented: $showCreateTransaction) {
                NavigationStack {
                    CreateTransactionView(dateInterval: DateInterval(start: budget.startDate, end: budget.endDate), onTransactionCreated:  { transaction,_,_  in
                        budget.transactions.append(transaction)
                    })
                    
                }.presentationDetents([.fraction(0.4)])
            }
            
        }
       .toolbar {
           
           if isPreview {
               ToolbarItem(placement: .cancellationAction) {
                   Button("Dismiss") {
                       dismiss()
                   }
               }
           }
       }
        
    }
    
}

#Preview {
    BudgetDetailView(budget: .dummy)
}
