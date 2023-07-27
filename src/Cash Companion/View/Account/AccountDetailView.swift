//
//  BankAccountDetailView.swift
//  Cash Companion
//
//  Created by Niklas Pernter on 26.07.2023.
//

import SwiftUI

struct AccountDetailView: View {
    var account: Account
    @Environment(\.modelContext) private var modelContext

    @State private var showCreateTransaction = false

    
    var body: some View {
                
        NavigationView {
            List {
                
                Section(header: Text("Account Info")) {
                    VStack {
                        HStack {
                            Text("Amount")
                            Spacer()
                            Text("\(account.nettoAmount, specifier: "%.2f")")
                            
                        }
                    }
                }
                
                TransactionSection(title: "Transactions", transactions: account.transactions, onDelete: { transaction in
                    account.transactions.remove(object: transaction)
                }).withAnalytics()
            }
            
        }
        .navigationTitle(account.name)
        .safeAreaInset(edge: .bottom,
                       alignment: .leading) {
            Button(action: {
                showCreateTransaction = true
            }, label: {
                FabActionButton(labelTitel: "New Transaction")
            }).sheet(isPresented: $showCreateTransaction) {
                NavigationStack {
                    CreateTransactionView(onTransactionCreated:  { transaction,_,_ in
                        account.transactions.append(transaction)
                    })
                    
                }.presentationDetents([.medium])
            }
            
        }
    }
}

#Preview {
    AccountDetailView(account: .dummy)
}
