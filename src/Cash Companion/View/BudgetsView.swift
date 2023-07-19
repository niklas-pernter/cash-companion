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
    @EnvironmentObject var selectedBudget: SelectedBudget // Use EnvironmentObject here

    
    var body: some View {
        NavigationView {
            List {
                if budgets.isEmpty {
                    ContentUnavailableView("You don't have any Budgets yet", systemImage: "dollarsign.circle")
                } else {
                    ForEach(budgets) { budget in
                        NavigationLink {
                            BudgetDetailView(budget: budget)
                        } label: {
                            VStack(alignment: .leading){
                                HStack{
                                    Text(budget.name)
                                    Spacer()
                                    Text(String(budget.getNetto()) + "$")
                                }
                                
                                HStack{
                                    Text(budget.startDate, style: .date)
                                        .foregroundColor(.gray)
                                        .font(.subheadline)
                                    Text(" - ")
                                        .foregroundColor(.gray)
                                        .font(.subheadline)
                                    Text(budget.endDate, style: .date)
                                        .foregroundColor(.gray)
                                        .font(.subheadline)
                                }
                                
                            }
                        }
                        
                    }.onDelete(perform: deleteBudget(offsets:))
                }
                
            }
            .navigationTitle("Budgets")
            .toolbar {
                ToolbarItem {
                    Button(action: {showCreateBudget = true}) {
                        Label("Create Transaction", systemImage: "plus")
                    }.sheet(isPresented: $showCreateBudget) {
                        NavigationStack {
                            CreateBudgetView()
                            
                        }.presentationDetents([.medium])
                    }
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

}

#Preview {
    NavigationStack {
        BudgetsView()
        
    }
}
