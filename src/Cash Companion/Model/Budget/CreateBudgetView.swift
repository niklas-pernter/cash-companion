//
//  CreateBudgetView.swift
//  Cash Companion
//
//  Created by Niklas Pernter on 13.07.2023.
//

import SwiftUI

struct CreateBudgetView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var startDate: Date = .now
    @State private var endDate: Date = .now
    @State var amount: Double = 0.0
    
    @State private var name: String = ""
    @FocusState private var nameIsFocused: Bool

    var body: some View {
        Form {
            
            Section {
                HStack {
                    Text("Name")
                    Spacer()
                    TextField("", text: $name).focused($nameIsFocused)
                }
            }.onAppear{
                self.nameIsFocused = true
            }
            
            
            
            Section{
                
                DatePicker("Start", selection: $startDate, displayedComponents: .date)
                DatePicker("End", selection: $endDate, displayedComponents: .date)
                
            }
            
            Section{
                HStack {
                    Text("Amount")
                    Spacer()
                    TextField("Amount", value: $amount, formatter: NumberFormatter())
                }
                
            }
            
            
            
            Button("Create Budget") {
                withAnimation {
                    let budget = Budget(name: name, startDate: startDate, endDate: endDate, amount: amount)
                    modelContext.insert(budget)
                    dismiss()
                }
            }
            .disabled(name.isEmpty)
            
        }
        .navigationTitle("Create Budget")
        .toolbar {
            
            ToolbarItem(placement: .cancellationAction) {
                Button("Dismiss") {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    CreateBudgetView()
}
