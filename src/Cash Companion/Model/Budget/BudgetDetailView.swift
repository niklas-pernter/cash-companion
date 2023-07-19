//
//  BudgetDetailView.swift
//  Cash Companion
//
//  Created by Niklas Pernter on 13.07.2023.
//

import SwiftUI
import SwiftData

struct BudgetDetailView: View {
    @Bindable var budget: Budget
    @Environment(\.modelContext) private var modelContext
    
    @State private var showCreateTransaction = false
    
    
    var body: some View {
        List {
            
            Section(header: Text("Transactions")){
                Button {
                    showCreateTransaction = true
                } label: {
                    Label("Create Transaction", systemImage: "plus")
                }
                ForEach(budget.transactions) { transaction in
                    VStack(alignment: .leading) {
                        HStack {
                            Text(transaction.title)
                            Spacer()
                            Text(String(transaction.amount) + "$")
                        }
                        Text(transaction.timestamp, style: .date)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }.swipeActions(allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            withAnimation {
                                modelContext.delete(transaction)
                                budget.transactions.remove(object: transaction)
                            }
                        } label: {
                            Label("Delete", systemImage: "trash.fill")
                        }
                        
                        Button {
                            
                        } label: {
                            Label("Update", systemImage: "pencil.circle.fill")
                        }
                    }
                    
                }
            }
        }
        .navigationTitle(budget.name)
        .sheet(isPresented: $showCreateTransaction, content: {
            NavigationView{
                CreateTransactionView(budget: budget)

            }.presentationDetents([.medium])

        })
        
    }

}

#Preview {
    BudgetDetailView(budget: .dummy)
}
