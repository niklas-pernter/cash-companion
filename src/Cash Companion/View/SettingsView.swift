//
//  SettingsView.swift
//  Cash Companion
//
//  Created by Niklas Pernter on 19.07.2023.
//

import SwiftUI
import SwiftData
import AuthenticationServices


struct SettingsView: View {
    @Environment(\.colorScheme) var colorScheme
    @Query private var accounts: [Account]


    var body: some View {
        NavigationView {
            List {
                
                
                    
               
            }.navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
