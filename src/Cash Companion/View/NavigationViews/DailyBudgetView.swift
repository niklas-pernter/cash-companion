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
    
    @State private var distribute = false
    @State private var showBudgetPreview = false
    @State private var showCreateBudget = false
    
    var body: some View {
        NavigationView {
            List {
                if budgets.isEmpty {
                    
                    CustomNoContentView(
                        imageName: "dollarsign.circle",
                        message: "You don't have any Budgets yet",
                        buttonLabel: "Create one!",
                        sheetContent: AnyView(
                            NavigationStack {
                                CreateBudgetView()
                            }.presentationDetents([.medium])
                        )
                    )
                    
                } else {
                    if let budget = selectedBudget.budget {
                        
                        Section {
                            VStack {
                                BudgetListRowView(budget: budget, onDelete: {_ in}).withSwipeActions(actions: false)
                                if !budget.transactions.isEmpty {
                                    TransactionsBarChartView(transactions: budget.transactions, title: "")

                                    
                                }
                            

                            }.onTapGesture {
                                showBudgetPreview = true
                            }
                            .contextMenu {
                                Button {
                                    showBudgetPreview = true
                                } label: {
                                    Label("Open", systemImage: "cursorarrow.click")
                                }
                            } preview: {
                                NavigationStack{
                                    BudgetDetailView(budget: budget)
                                }
                            }
                            .sheet(isPresented: $showBudgetPreview, content: {
                                NavigationStack {
                                    BudgetDetailView(budget: budget, isPreview: true)
                                }
                            })
                                                        
                        }
                        

                        
                        
                        Section {
                            Toggle("Distribute cash", isOn: $distribute).onTapGesture(perform: {
                                Haptics.shared.play(.soft)
                            })
                        } footer: {
                            Text("When enabled, any remaining cash will be distributed evenly across all days, helping to balance your budget.")
                        }
                        
                        Section(header: Text(Date().toString())) {
                            HStack{
                                Spacer()
                                VStack {
                                    Text("Today")
                                        .font(.title)
                                        .fontWeight(.bold)
                                    Text(budget.calculateDailyBudget(distribute: distribute).asCurrency())
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .padding(.leading)
                                        .padding(.trailing)
                                }
                                Spacer()
                                
                                VStack {
                                    Text("Tomorrow")
                                    if distribute {
                                        Text(budget.calculateDailyBudget(distribute: distribute).asCurrency()).font(.caption)
                                    } else {
                                        HStack {
                                            Text((budget.calculateDailyBudget(distribute: distribute, customCurrentDate: Date().addDays(days: 1)) - budget.calculateDailyBudget(distribute: distribute, customCurrentDate: Date().addDays(days: 0))).asCurrency()).font(.caption)
                                            Text("-").font(.caption)
                                            Text(budget.calculateDailyBudget(distribute: distribute, customCurrentDate: Date().addDays(days: 1)).asCurrency()).font(.caption)
                                        }
                                        
                                    }
                                    
                                }
                                Spacer()
                                
                            }
                        }.headerProminence(.increased)
                        
                        HStack {
                            Spacer()
                            Button(action: {
                                print("Round Action")
                            }) {
                                Image(systemName: "plus")
                                    .frame(width: 75, height: 75)
                                    
                                    .background(.blue.opacity(0.4))
                                    .clipShape(Circle())
                            }
                            Spacer()
                        }.listRowBackground(Color.blue.opacity(0))
                        
                        
                        
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu(content: {
                        ForEach(budgets, id: \.self) { budget in
                            Button(action: {selectedBudget.budget = budget}) {
                                Text(budget.name).foregroundColor(.gray)
                            }
                        }
                        
                    }, label: {
                        Label ("Destination", systemImage: "filemenu.and.selection")
                    })
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        SettingsView()
                    } label: {
                        Image(systemName: "person.crop.circle")
                    }
                }
                
                
            }
            .onAppear {
                selectedBudget.budget = selectedBudget.budget ?? budgets.first
            }
            .navigationTitle("Daily Budget")

        }
    }
    
    
    
    
}




#Preview {
    DailyBudgetView()
}
