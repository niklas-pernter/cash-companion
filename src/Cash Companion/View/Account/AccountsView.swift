//
//  AccountsView.swift
//  Cash Companion
//
//  Created by Niklas Pernter on 26.07.2023.
//

import SwiftUI
import SwiftData

struct AccountsView: View {
    @Query private var accounts: [Account]
    
    @State var showTransferSheet: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    @State var selectedAccountFrom: Account? = nil
    @State var selectedAccountTo: Account? = nil
    
    @State private var amount: Double = 0.0
    
    var body: some View {
        
        List {
            
            Button(action: {showTransferSheet = true}) {
                Label("Transfer Between accounts", systemImage: "arrow.left.arrow.right")
            }.sheet(isPresented: $showTransferSheet) {
                NavigationStack {
                    CreateTransactionView(transactionMode: .transfer, selectableTransactionModes: [.transfer], onTransactionCreated: { transaction, AccountFrom, AccountTo in
                        let transactionForFromAccount = Transaction(name: transaction.name, createdAt: transaction.createdAt, amount: -transaction.amount)
                        transactionForFromAccount.category = transaction.category
                        AccountFrom?.transactions.append(transactionForFromAccount)
                        AccountTo?.transactions.append(transaction)
                    })
                    
                    
                }.presentationDetents([.fraction(0.6)])
                
                
            }
            
            
            
            Section(header: Text("Accounts")) {
                ForEach(accounts, id: \.self) { account in
                    AccountListRow(account: account)
                    
                }
            }.headerProminence(.increased)
        }.navigationTitle("Accounts")
        
    }
}

#Preview {
    AccountsView()
}
