//
//  CreateTransactionView.swift
//  Cash Companion
//
//  Created by Niklas Pernter on 13.07.2023.
//

import SwiftUI
import SwiftData
import CurrencyField


enum SignedNumber {
    case positive, negative
}

struct CreateTransactionView: View {
   
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) var modelContext
    
    @Query private var categories: [Category]
    @Query private var accounts: [Account]
    
    @State private var name = ""
    @State private var amountCents: Int = 0
    @State private var createdAt = Date()
    @State private var selectedCategory: Category? = nil
    @State private var amountSigned: SignedNumber = SignedNumber.positive
    
    var dateInterval: DateInterval?
    var onTransactionCreated: (Transaction, Account?, Account?) -> Void
    var isAccountTransfer: Bool = false

    @State var selectedAccountFrom: Account? = nil
    @State var selectedAccountTo: Account? = nil
    
    var body: some View {
        
        Form {
            
            Section {
                HStack {
                    Spacer()
                    VStack {
                        
                        HStack {
                            Button{} label: {
                                Image(systemName: "plus")
                            }.padding()
                                .background(.green)
                                .frame(height: 40)
                                .frame(width: 40)
                                .foregroundColor(.white)
                                .clipShape(Rectangle())
                                .cornerRadius(10)
                                .onTapGesture(perform: {
                                    withAnimation{
                                        amountSigned = SignedNumber.positive
                                    }
                                })
                            
                            Button{} label: {
                                Image(systemName: "minus")
                            }.padding()
                                .background(.red)
                                .frame(height: 40)
                                .frame(width: 40)
                                .foregroundColor(.white)
                                .clipShape(Rectangle())
                                .cornerRadius(10)
                                .onTapGesture(perform: {
                                    withAnimation{
                                        amountSigned = SignedNumber.negative

                                    }
                                })
                        
                        }.listRowBackground(Color.blue.opacity(0)).visible(!isAccountTransfer)
                            
                        
                        CurrencyField(value: $amountCents)
                                            .font(.largeTitle.monospaced())
                                            .multilineTextAlignment(.center)
                                            .font(.title)
                                            .fontWeight(.bold)
                                            .foregroundColor(amountSigned == SignedNumber.positive ? .green : .red)

                       
                    }
                    Spacer()

                }
               
            }.listRowBackground(Color.blue.opacity(0))
            
            Section {
                HStack {
                    TextField("Name", text: $name)
                    Divider()
                    if let dateInterval = dateInterval {
                        DatePicker("", selection: $createdAt, in: dateInterval.start...dateInterval.end, displayedComponents: .date)
                    } else {
                        DatePicker("", selection: $createdAt, displayedComponents: .date)
                    }
                }
                
                Picker("Pick a Category", selection: $selectedCategory) {
                    ForEach(categories, id: \.self) { category in
                        Text(category.name).tag(category as Category?)
                    }
                    Text("None").tag(nil as Category?)
                }
            }
            
            
            if isAccountTransfer {
                Section(header: Text("Transfer")) {
                    Picker(selection: $selectedAccountFrom, label: Text("Account from")) {
                        ForEach(accounts, id: \.self) { account in
                            Text(account.name).tag(account as Account?)
                        }
                    }
                    
                    Picker(selection: $selectedAccountTo, label: Text("Account to")) {
                        ForEach(accounts, id: \.self) { account in
                            Text(account.name).tag(account as Account?)
                        }
                    }
                }
            }
            
            Button("Create Transaction") {
                
                let transaction = Transaction(name: name.isEmpty ? nil : name, createdAt: createdAt, amount: amountSigned == SignedNumber.positive ? Double(amountCents/100) : Double(-amountCents/100))
                transaction.category = selectedCategory;
                onTransactionCreated(transaction, selectedAccountFrom, selectedAccountTo)
                Haptics.shared.notify(.success)
                dismiss()
            }
        }.toolbar {
            
            ToolbarItem(placement: .cancellationAction) {
                Button("Dismiss") {
                    dismiss()
                }
            }
        }.navigationTitle("Create Transaction")
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    CreateTransactionView(onTransactionCreated: {_,_,_  in })
}

extension CreateTransactionView {
    
    func asAccountTransfer(_ transfer: Bool) -> some View {
        return CreateTransactionView(onTransactionCreated: self.onTransactionCreated, isAccountTransfer: true)
    }
}
