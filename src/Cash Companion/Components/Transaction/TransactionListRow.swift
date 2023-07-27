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
                
                Text(transaction.category?.name ?? "").visible(transaction.category != nil)
                    .font(.caption)
                    .foregroundStyle(.blue)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 4)
                    .background(Color.blue.opacity(0.1), in:
                        RoundedRectangle(
                            cornerRadius: 8,
                            style: .continuous
                        ))
                

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
