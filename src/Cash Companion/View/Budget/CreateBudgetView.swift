//
//  CreateBudgetView.swift
//  Cash Companion
//
//  Created by Niklas Pernter on 13.07.2023.
//

import SwiftUI

enum FocusedField {
    case name, amount, starDate, endDate
}

struct CreateBudgetView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date().addDays(days: 1)
    @State var amount: Double = 0.0
    
    @State private var name: String = ""
    @FocusState private var focusedField: FocusedField?
    
    var body: some View {
        Form {
            
            Section {
                HStack {
                    TextField("Name", text: $name).focused($focusedField, equals: .name)
                    Divider()
                    TextField("Amount", value: $amount, formatter: NumberFormatter.dollarNumberFormatter)
                }
            }
            
            
            
            Section{
                
                DatePicker("Start", selection: $startDate, displayedComponents: .date)
                    .onChange(of: startDate) {
                        if startDate > endDate {
                            endDate = startDate
                        }
                    }
                DatePicker("End", selection: $endDate, in: startDate.addDays(days: 1)..., displayedComponents: .date)
                    .onChange(of: endDate) {
                        if endDate < startDate {
                            startDate = endDate
                        }
                    }
                
            }
            
            Button("Create Budget") {
                withAnimation {
                    let budget = Budget(name: name, startDate: startDate, endDate: endDate, amount: amount)
                    modelContext.insert(budget)
                    Haptics.shared.notify(.success)
                    dismiss()
                }
            }
            .disabled(name.isEmpty)
            
        }.onAppear {
            focusedField = .name
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
