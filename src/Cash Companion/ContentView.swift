//
//  ContentView.swift
//  Cash Companion
//
//  Created by Niklas Pernter on 13.07.2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @StateObject private var selectedBudget = SelectedBudget()
    
    
    var body: some View {
        
        TabView {
            DailyBudgetView()
                .tabItem {
                    Image(systemName: "dollarsign")
                    Text("Daily Budget")
                }
            
            BudgetsView()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("Budgets")
                }
            
            TransactionsView()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("Transactions")
                }
            
            DashboardView()
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("Dashboard")
                }
            
            
        }
        .environmentObject(selectedBudget)
        .background(.ultraThinMaterial)
        
        
        
        
    }
}


