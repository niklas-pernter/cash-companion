//
//  CreateTransactionView.swift
//  Cash Companion
//
//  Created by Niklas Pernter on 13.07.2023.
//

import SwiftUI

struct CreateTransactionView: View {
    @Bindable var budget: Budget

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var title = ""
    @State private var amount = ""
    @State private var timestamp = Date()
    
    
    var body: some View {
        
        Form {
            
            Section {
                TextField("Title", text: $title)
                DatePicker("Date", selection: $timestamp, in: budget.startDate...budget.endDate, displayedComponents: .date)
                TextField("Amount", text: $amount)
            }
            
            
            Button("Create Transaction") {
                let transaction = Transaction(title: title,
                                              timestamp: timestamp,
                                              amount: Double(amount) ?? 0)
                budget.transactions.append(transaction)
                dismiss()
            }
        }.toolbar {
            
            ToolbarItem(placement: .cancellationAction) {
                Button("Dismiss") {
                    dismiss()
                }
            }
        }.navigationTitle("Create Transaction")
    }
}

#Preview {
    CreateTransactionView(budget: .dummy)
}
