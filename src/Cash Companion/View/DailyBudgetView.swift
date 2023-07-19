//
//  DailyBudgetView.swift
//  Cash Companion
//
//  Created by Niklas Pernter on 13.07.2023.
//

import SwiftUI
import SwiftData

struct DailyBudgetView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var budgets: [Budget]
    @EnvironmentObject var selectedBudget: SelectedBudget
    
    var body: some View {
        NavigationView {
            List {
                if budgets.isEmpty {
                    ContentUnavailableView("You don't have any Budgets yet", systemImage: "dollarsign.circle")
                } else {
                    if let budget = selectedBudget.budget {
                        
                        NavigationLink{
                            BudgetDetailView(budget: budget)
                        } label: {
                            VStack(alignment: .leading){
                                if(!Util().isInsideBudgetDate(start: budget.startDate, end: budget.endDate)) {
                                    Text("Not Inside Budget Date range")
                                        .foregroundColor(.red)
                                        .font(.caption)
                                }
                                HStack {
                                    Text(budget.name).font(.title).fontWeight(.bold)
                                    Text(String(budget.getNetto()) + "$").fontWeight(.bold)
                                }
                                HStack {
                                    Text(budget.startDate,style: .date)
                                    Text(" - ")
                                    Text(budget.endDate,style: .date)
                                }.foregroundColor(.gray)
                                    .font(.subheadline)
                            }
                        }
                        

                        
                        Section(header: Text("Budget for today")) {
                            Text("\(Util().calculateRemainingDailyBudget(budget: budget, distribute: false) ?? 0.0, specifier: "%.2f")$")
                                .font(.title)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .padding()
                        }
                    }
                }
            }
            .navigationTitle("Daily Budget")
            .toolbar {
                Menu(content: {
                    ForEach(budgets, id: \.self) { budget in
                        Button(action: {selectedBudget.budget = budget}) {
                            Text(budget.name).foregroundColor(.gray)
                        }
                    }
                    
                    Text("None").foregroundColor(.gray).disabled(true)
                    
                }, label: {
                    Label ("Destination", systemImage: "filemenu.and.selection")
                })
            }
        }.onAppear {
            selectedBudget.budget = budgets.first
        }
    }
    
    
    
    
}




#Preview {
    DailyBudgetView()
}
