//
//  TransactionListRow.swift
//  Cash Companion
//
//  Created by Niklas Pernter on 26.07.2023.
//

import Foundation
import SwiftUI

struct TransactionListRow: View {
    
    let transaction: Transaction
    let onDelete: () -> Void
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                Text(transaction.name ?? "Unnamed")
                
                if let category = transaction.category {
                    Text(category.name)
                        .font(.caption)
                        .padding(6)
                        .background(.blue.opacity(0.1))
                        .cornerRadius(8)
                }
                
                
                Spacer()
                Text(String(transaction.amount) + "$")
            }
            Text(transaction.createdAt, style: .date)
                .font(.subheadline)
                .foregroundColor(.gray)
            
        }.swipeActions(allowsFullSwipe: true) {
            Button(role: .destructive) {
                withAnimation {
                    onDelete()
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
    }
}
