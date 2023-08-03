//
//  TransactionsBarChartView.swift
//  Cash Companion
//
//  Created by Niklas Pernter on 22.07.2023.
//

import SwiftUI
import Charts

struct TransactionData {
    let createdAt: Date
    let amount: Double
}

struct TransactionsBarChartView: View {
    
    let transactions: [Transaction]
    var title = "Transactions"
    
    // Calculate transactions grouped by day
    func transactionsByDay(extract: (Transaction) -> TransactionData) -> [(createdAt: Date, amount: Double)] {
        let transformedTransactions = transactions.map(extract)
        let groupedTransactions = Dictionary(grouping: transformedTransactions, by: { Calendar.current.startOfDay(for: $0.createdAt) })
        return groupedTransactions.map { (createdAt: $0.key, amount: $0.value.reduce(0) { $0 + $1.amount }) }
    }
    
    var body: some View {
        let dataByDay = transactionsByDay { TransactionData(createdAt: $0.createdAt, amount: $0.amount) }

        
        VStack {
            
            HStack {
                Text(title).fontWeight(.semibold).visible(!title.isEmpty)
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
                
            }
            .padding()
            
        }
    }
    
    
}



#Preview {
    TransactionsBarChartView(transactions: [])
}
