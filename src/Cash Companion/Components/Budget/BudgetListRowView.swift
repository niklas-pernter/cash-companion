//
//  BudgetListRowView.swift
//  Cash Companion
//
//  Created by Niklas Pernter on 24.07.2023.
//

import SwiftUI

enum RedirectType {
    case sheet, view
}

struct BudgetListRowView: View {
    let budget: Budget
    
    let onDelete: (Budget) -> Void
    var includeSwipeActions: Bool = true

    
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                Text(budget.name).font(.title2).fontWeight(.bold)
                Spacer()
                HStack {
                    Text(budget.startDate,style: .date)
                    Text(" - ")
                    Text(budget.endDate,style: .date)
                }.foregroundColor(.gray).font(.caption)
            }
            
            HStack {
                Text(budget.amount.asCurrency())
                Image(systemName: "arrow.right")
                Text(budget.nettoAmount.asCurrency())
                Spacer()
                HStack {
                    if(budget.remainingDays == nil) {
                        Text("Expired").font(.caption).foregroundColor(.red)
                        Image(systemName: "clock")
                            .font(.caption).foregroundColor(.red)
                    } else {
                        Text(String(budget.remainingDays!) + " Days").font(.caption)
                        Image(systemName: "clock")
                            .font(.caption)
                    }
                        

                }

            }
        }.swipeActions(allowsFullSwipe: true) {
            if includeSwipeActions {
                Button(role: .destructive) {
                    withAnimation {
                        onDelete(budget)
                    }
                } label: {
                    Label("Delete", systemImage: "trash.fill")
                }
            }
        }
    }
}

#Preview {
    BudgetListRowView(budget: .dummy, onDelete: {_ in})
}

extension BudgetListRowView {
    func withSwipeActions(actions: Bool) -> some View {
        BudgetListRowView(budget: self.budget, onDelete: self.onDelete, includeSwipeActions: actions)
    }
}
