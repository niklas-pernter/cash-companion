//
//  CreateTransactionImproved.swift
//  Cash Companion
//
//  Created by Niklas Pernter on 31.07.2023.
//

import SwiftUI
import CurrencyField
import SwiftData


enum TransactionMode {
    case income, expense, transfer
}

struct CreateTransactionView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Query var accounts: [Account]
    @Query var categories: [Category]
    
    @State var amountCents: Int = 0
    @State var transactionMode: TransactionMode = TransactionMode.income
    
    @State var name = ""
    @State var createdAt = Date()
    @State var selectedCategory: Category?
    
    @State var selectedFromAccount: Account? = nil
    @State var selectedToAccount: Account? = nil
        
    var dateInterval: DateInterval?
    var selectableTransactionModes: [TransactionMode] = [.income,.expense,.transfer]
    var onTransactionCreated: (Transaction, Account?, Account?) -> Void = {_,_,_ in}
    
    
    
    var body: some View {
        
        Form {
            
            AmountInputView(amountCents: $amountCents, transactionMode: $transactionMode, selectableOptions: selectableTransactionModes).listRowBackground(Color.clear)
                        
            TransactionInfoView(
                name: $name,
                date: $createdAt,
                categories: categories,
                selectedCategory: $selectedCategory
            )
            
            if transactionMode == .transfer {
                AccountTransferView(
                    accounts: accounts,
                    selectedFromAccount: $selectedFromAccount,
                    selectedToAccount: $selectedToAccount
                )
            }
            
        }.onAppear {
            if transactionMode == .transfer {
                selectedCategory = categories.filter { category in
                    return category.name == "Transfer"
                }.first
            }
        }
        .navigationTitle("Create Transaction")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Dismiss") {
                    dismiss()
                }.foregroundColor(.red)
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Create") {
                    create()
                }
            }
        }
        
    }
    func create() {
        let transaction = Transaction(name: name.isEmpty ? nil : name, createdAt: createdAt, amount: transactionMode == .income ? amountCents.toDollars() : -amountCents.toDollars())
        transaction.category = selectedCategory;
        onTransactionCreated(transaction, selectedFromAccount, selectedToAccount)
        Haptics.shared.notify(.success)
        dismiss()
    }
}
struct AmountInputView: View {
    
    @Binding var amountCents: Int
    @Binding var transactionMode: TransactionMode
    var selectableOptions: [TransactionMode] 

    var body: some View {
        HStack {
            Spacer()
            VStack {
                    Picker("", selection: $transactionMode) {
                        ForEach(selectableOptions, id: \.self) { option in
                            Text(textForTransactionMode(option)).tag(option)
                        }
                        
                        
                    }
                    .pickerStyle(.segmented)
                

                
                CurrencyField(value: $amountCents)
                    .font(.largeTitle.monospaced())
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(transactionMode == .income ? .green : (transactionMode == .transfer ? .blue : .red))

                
                
            }
            Spacer()
            
        }
    }
    
    private func textForTransactionMode(_ mode: TransactionMode) -> String {
        switch mode {
        case .income:
            return "Income"
        case .expense:
            return "Expense"
        case .transfer:
            return "Transfer"
        }
    }
    
}

struct TransactionInfoView: View {
    
    @Binding var name: String
    @Binding var date: Date
    let categories: [Category]
    @Binding var selectedCategory: Category?
    
    var body: some View {
        
        Section {
            HStack {
                TextField("Name", text: $name)
                DatePicker("Date", selection: $date, displayedComponents: .date)
            }
            
            Picker("Category", selection: $selectedCategory) {
                ForEach(categories, id: \.self) { category in
                    Text(category.name).tag(category as Category?)
                }
                Text("None").tag(nil as Category?)
            }
        }
        
    }
    
}

struct AccountTransferView: View {
    var accounts: [Account]
    
    @Binding var selectedFromAccount: Account?
    @Binding var selectedToAccount: Account?
    
    var body: some View {
        Section(header: Text("Transfer")) {
            Picker("From", selection: $selectedFromAccount) {
                ForEach(accounts, id: \.self) { account in
                    Text(account.name).tag(account as Account?)
                }
            }
            
            Picker("To", selection: $selectedToAccount) {
                ForEach(accounts, id: \.self) { account in
                    Text(account.name).tag(account as Account?)
                }
            }
        }
    }
}
