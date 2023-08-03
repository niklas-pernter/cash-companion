//
//  BudgetDetailView.swift
//  Cash Companion
//
//  Created by Niklas Pernter on 13.07.2023.
//

import SwiftUI
import SwiftData
import Charts

struct BudgetDetailView: View {
    @Bindable var budget: Budget
    var isPreview: Bool = false
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var showCreateTransaction = false
    
    func transactionsByDay(extract: (Transaction) -> TransactionData) -> [(createdAt: Date, amount: Double)] {
        let transformedTransactions = budget.transactions.map(extract)
        let groupedTransactions = Dictionary(grouping: transformedTransactions, by: { Calendar.current.startOfDay(for: $0.createdAt) })
        return groupedTransactions.map { (createdAt: $0.key, amount: $0.value.reduce(0) { $0 + $1.amount }) }
    }
    
    var body: some View {
        let dataByDay = transactionsByDay { TransactionData(createdAt: $0.createdAt, amount: $0.amount) }

        
        
        
        List {
            
            Section {
                VStack {
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text(budget.nettoAmount.asCurrency()).fontWeight(.bold).font(.title)
                            Text(budget.startDate.toString() + " - " + budget.endDate.toString()).font(.caption).foregroundStyle(.gray)
                        }
                        Spacer()
                        HStack {
                            if(budget.remainingDays == nil) {
                                Text("Expired").font(.caption).foregroundColor(.red)
                                Image(systemName: "clock")
                                    .font(.caption).foregroundColor(.red)
                            } else {
                                Text(budget.remainingDays!.toString().formatToDays()).font(.caption)
                                Image(systemName: "clock")
                                    .font(.caption)
                            }
                                

                        }
                    }
                    Chart {
                        ForEach(dataByDay, id: \.createdAt) { transactionByDay in
                            BarMark(
                                x: .value("Date", transactionByDay.createdAt, unit: .day),
                                y: .value("Amount", transactionByDay.amount)
                            ).foregroundStyle(transactionByDay.amount >= 0 ? Color.blue : Color.red)
                                
                        }
                    }
                    .chartYAxis {
                        AxisMarks(stroke: StrokeStyle(dash: [2,2]))
                    }
                    .chartXAxis{
                        AxisMarks(stroke: StrokeStyle(lineWidth: 0))
                        
                    }.frame(height: 250)
                    
                    
                }.padding()
            }
            

            
            Section(header: Text("Details")) {
                HStack {
                    Label("Initial Balance", systemImage: "creditcard")
                    Spacer()
                    Text(budget.amount.asCurrency())
                }
                
                HStack {
                    Label("Created At", systemImage: "calendar.badge.plus")
                    Spacer()
                    Text(budget.createdAt.toString())
                }
                HStack {
                    Label("Duration", systemImage: "clock")
                    Spacer()
                    Text(budget.duration.toString().formatToDays())
                }
                                
            }
            
            
            
            TransactionSection(title: "Transactions", transactions: budget.transactions.sorted(), onDelete: { transaction in
                budget.transactions.remove(object: transaction)
            })
        }
        .listStyle(.sidebar)
        // Add the AccordionStyle here to enable collapsing/expanding sections

        
        .navigationTitle(budget.name)
        .navigationBarTitleDisplayMode(.large)
        .safeAreaInset(edge: .bottom,
                       alignment: .leading) {
            Button(action: {
                showCreateTransaction = true
            }, label: {
                FabActionButton(labelTitel: "New Transaction")
            }).sheet(isPresented: $showCreateTransaction) {
                NavigationStack {
                    CreateTransactionView(dateInterval: DateInterval(start: budget.startDate, end: budget.endDate), onTransactionCreated:  { transaction,_,_  in
                        budget.transactions.append(transaction)
                    })
                }.presentationDetents([.fraction(0.4)])
                    .presentationBackground(.ultraThinMaterial)
            }
            
        }
       .toolbar {
           
           if isPreview {
               ToolbarItem(placement: .cancellationAction) {
                   Button("Dismiss") {
                       dismiss()
                   }
               }
           }
       }
        
    }
    
}

#Preview {
    BudgetDetailView(budget: .dummy)
}
