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
    var isPreview: Bool = false // Add this line
    
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var showCreateTransaction = false
    
    
    
    var body: some View {
        List {
            
            Section(header: Text("Transactions")){
                
                if budget.transactions.isEmpty {
                    ContentUnavailableView("You don't have any Transactions yet", systemImage: "list.bullet")
                } else {
                    ForEach(budget.transactions) { transaction in
                        VStack(alignment: .leading) {
                            HStack {
                                Text(transaction.title)
                                Spacer()
                                Text(String(transaction.amount) + "$")
                            }
                            Text(transaction.timestamp, style: .date)
                                .font(.subheadline)
                                .foregroundColor(.gray)

                        }
                        .swipeActions(allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                withAnimation {
                                    modelContext.delete(transaction)
                                    budget.transactions.remove(object: transaction)
                                }
                            } label: {
                                Label("Delete", systemImage: "trash.fill")
                            }
                            
                            Button {
                                
                            } label: {
                                Label("Update", systemImage: "pencil.circle.fill")
                                    .tint(.yellow)
                            }
                        }
                        
                    }.listRowSeparator(.hidden)
                    HStack{
                        Spacer()
                        Text("\(budget.getTransactionsValue(), specifier: "%.2f")$").fontWeight(.bold)
                    }
                }
                
                
            }
            
            if budget.transactions.count >= 2 {
                Section(header: Text("Analytics")) {
                    Chart {
                        ForEach(budget.transactions.sorted { $0.timestamp > $1.timestamp } ) { transaction in
                            
                            LineMark(
                                x: .value("Date", transaction.timestamp, unit: .day),
                                y: .value("Amount", abs(transaction.amount))
                            )
                            .interpolationMethod(.catmullRom)
                            .foregroundStyle(.blue)
                            .lineStyle(StrokeStyle(lineWidth: 3))
                            
                            .symbolSize(30)
                            
                            AreaMark(
                                x: .value("Date", transaction.timestamp, unit: .day),
                                y: .value("Amount", abs(transaction.amount))
                            )
                            .interpolationMethod(.catmullRom)
                            .foregroundStyle(Color(red: 0.0, green: 0.0, blue: 1.0, opacity: 0.2))
                        }
                    }
                    .chartYAxis {
                        AxisMarks() {
                            let value = -$0.as(Int.self)!
                            AxisValueLabel {
                                Text("\(value)")
                            }
                        }
                    }
                    .chartXAxis{
                        AxisMarks(stroke: StrokeStyle(lineWidth: 0))
                        
                    }
                    .padding(.top)
                }
            }
            
        }
        .navigationTitle(budget.name)
        .safeAreaInset(edge: .bottom,
                       alignment: .leading) {
            Button(action: {
                showCreateTransaction = true
            }, label: {
                Label("New Transaction", systemImage: "plus")
                    .padding(6)
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                    .background(.gray.opacity(0.1),
                                in: Capsule())
                    .padding(.leading)
                    .padding(.bottom)
                    .symbolVariant(.circle.fill)
                
            }).sheet(isPresented: $showCreateTransaction) {
                NavigationStack {
                    CreateTransactionView(budget: budget)
                    
                }.presentationDetents([.medium])
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
