//
//  TransactionsSection.swift
//  Cash Companion
//
//  Created by Niklas Pernter on 26.07.2023.
//

import Foundation
import SwiftUI

struct CategoryView: Identifiable {
    var id = UUID()
    var name: String
    let transactions: [Transaction]
}


struct TransactionSection: View {
    let title: String
    let transactions: [Transaction]
    
    var showAnalytics: Bool = false
    
    @Environment(\.modelContext) private var modelContext
    
    let onDelete: (Transaction) -> Void
    var categorized: Bool = false
    
    var body: some View {
        
        
        
        Section(header: Text(title)){
            if transactions.isEmpty {
                ContentUnavailableView("You don't have any Transactions yet", systemImage: "list.bullet")
            } else {
                ForEach(transactions) { transaction in
                    TransactionListRow(transaction: transaction) {
                        modelContext.delete(transaction)
                        onDelete(transaction)
                    }
                }
                HStack{
                    Spacer()
                    Text(transactions.summed.asCurrency()).fontWeight(.bold)
                }
            }
            
        }
        if showAnalytics && transactions.count >= 2 {
            Section(header: Text("Analytics")) {
                TransactionsBarChartView(transactions: transactions)
                
            }
            
        }
        
    }
}

extension TransactionSection {
    func withAnalytics() -> some View {
        TransactionSection(title: title, transactions: transactions, showAnalytics: true, onDelete: self.onDelete)
    }
    
    func withCategories(show: Bool = false) -> some View {
        TransactionSection(title: title, transactions: transactions, showAnalytics: true, onDelete: self.onDelete, categorized: show)
    }
}

