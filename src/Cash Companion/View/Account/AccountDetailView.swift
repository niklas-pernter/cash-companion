//
//  BankAccountDetailView.swift
//  Cash Companion
//
//  Created by Niklas Pernter on 26.07.2023.
//

import SwiftUI
import CurrencyField

struct AccountDetailView: View {
    @Bindable var account: Account
    @Environment(\.modelContext) private var modelContext
    
    @State private var showCreateTransaction = false
    @State var nameInEditMode = false
    @State var amountCents = 0
    
    var body: some View {
        
        NavigationView {
            List {
                
                Section(header: Text("Account Info")) {
                    VStack {
                        HStack {
                            
                            
                            if nameInEditMode {
                                CurrencyField(value: $amountCents).textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.all, 5)
                                    .background(Color(.systemGray4))
                                    .cornerRadius(5)
                                
                                
                            } else {
                                Text(account.initialAmount.asCurrency())
                            }
                            Spacer()
                            Button(action: {
                                nameInEditMode = true
                            }) {
                                if(nameInEditMode) {
                                    Text("Save").fontWeight(.light)
                                        .foregroundColor(Color.blue)
                                        .onTapGesture {
                                            account.initialAmount = amountCents.toDollars()
                                            nameInEditMode = false
                                        }
                                        
                                }
                                else {
                                    Text("Edit").fontWeight(.light)
                                        .foregroundColor(Color.blue).onTapGesture {
                                            nameInEditMode = true
                                        }
                                }
                                
                            }
                        }.onAppear {
                            amountCents = Int(account.initialAmount.toCents())
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
                    
                }.presentationDetents([.fraction(0.4)])
            }
            
        }
    }
}

