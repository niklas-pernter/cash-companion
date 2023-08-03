//
//  Budgets.swift
//  Cash Companion
//
//  Created by Niklas Pernter on 13.07.2023.
//

import SwiftUI
import SwiftData

struct BudgetsView: View {
    @Environment(\.modelContext) private var modelContext
    
    @State private var showCreateBudget = false
    @Query private var budgets: [Budget]
    @EnvironmentObject var selectedBudget: SelectedBudget
    
    var body: some View {
        let budgetExcludedSelected = budgets.filter {budget in budget != selectedBudget.budget}
        
        NavigationView {
            List {
                if budgets.isEmpty {
                    CustomNoContentView(imageName: "dollarsign.circle", message: "You don't have any Budgets yet")
                } else {
                    if(selectedBudget.budget != nil) {
                        Section(header: Text("Selected")) {
                            NavigationLink {
                                BudgetDetailView(budget: selectedBudget.budget!)
                            } label: {
                                BudgetListRowView(budget: selectedBudget.budget!) { budget in
                                    deleteBudget(budget: budget)
                                }
                            }
                        }
                    }
                    
                    ForEach(budgetExcludedSelected) { budget in
                        NavigationLink {
                            BudgetDetailView(budget: budget)
                        } label: {
                            BudgetListRowView(budget: budget, onDelete: { budget in
                                deleteBudget(budget: budget)
                                
                            })
                        }
                    }
                }
                
            }
            .navigationTitle("Budgets")
            .safeAreaInset(edge: .bottom,
                           alignment: .leading) {
                Button(action: {
                    showCreateBudget = true
                }, label: {
                    FabActionButton(labelTitel: "New Budget")
                }).sheet(isPresented: $showCreateBudget) {
                    NavigationStack {
                        CreateBudgetView()
                        
                    }.presentationDetents([.fraction(0.4)])
                }
                
            }
           .toolbar {
               NavigationLink {
                   SettingsView()
               } label: {
                   Image(systemName: "person.crop.circle")
               }
               
           }
           

        }
    }
    
    private func deleteBudget(offsets: IndexSet){
        for index in offsets {
            let budget = budgets[index]
            if budget == selectedBudget.budget {
                selectedBudget.budget = nil
            }
            modelContext.delete(budget)
        }
        try? modelContext.save()
    }
    
    private func deleteBudget(budget: Budget){
        if budget == selectedBudget.budget {
            selectedBudget.budget = nil
        }
        modelContext.delete(budget)
        try? modelContext.save()
    }
    
}

#Preview {
    NavigationStack {
        BudgetsView()
        
    }
}
