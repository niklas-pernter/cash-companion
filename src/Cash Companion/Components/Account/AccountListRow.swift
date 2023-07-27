//
//  BankListRow.swift
//  Cash Companion
//
//  Created by Niklas Pernter on 25.07.2023.
//

import Foundation
import SwiftData
import SwiftUI


struct AccountListRow: View {
    
    var account: Account
    
    var body: some View {
        NavigationLink {
            AccountDetailView(account: account)
        } label: {
            VStack {
                
                HStack {
                    Text(account.name)
                    Spacer()
                    Text("\(account.nettoAmount, specifier: "%.2f")$")
                }

            }
        }
        
        
    }
}
