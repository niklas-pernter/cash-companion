//
//  TransactionsView.swift
//  Cash Companion
//
//  Created by Niklas Pernter on 31.07.2023.
//

import SwiftUI
import SwiftData

struct TransactionsView: View {
    @State private var showCreateTransaction = false

    @Query var transactions: [Transaction]
    
    var body: some View {
        let groupedTransactions = Dictionary(grouping: transactions, by: { $0.createdAt })
        
        NavigationView {
            List {
                ForEach(groupedTransactions.sorted(by: { $0.key < $1.key }), id: \.key) { date, transactions in
                    Section(header: Text(date.toString())) {
                        ForEach(transactions) { transaction in
                            TransactionListRow(transaction: transaction) {
                            }
                        }
                        HStack{
                            Spacer()
                            Text(transactions.sum.asCurrency()).fontWeight(.bold)
                        }

                    }
            }

            
        
            
        }.navigationTitle("Transactions")
    
        }.safeAreaInset(edge: .bottom,
                        alignment: .leading) {
             Button(action: {
                 showCreateTransaction = true
             }, label: {
                 FabActionButton(labelTitel: "New Transaction")
             }).sheet(isPresented: $showCreateTransaction) {
                 NavigationStack {
                     CreateTransactionView()
                 }.presentationDetents([.fraction(0.4)])
                     .presentationBackground(.ultraThinMaterial)
             }
             
         }
    }
}

#Preview {
    TransactionsView()
}
