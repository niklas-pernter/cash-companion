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
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
            
            
            
        }.environmentObject(selectedBudget)
            .background(.ultraThinMaterial)
        
    }
}

#Preview {
    ContentView().modelContainer(for: Transaction.self, inMemory: true)
    
}
