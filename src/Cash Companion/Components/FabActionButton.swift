//
//  FabActionButton.swift
//  Cash Companion
//
//  Created by Niklas Pernter on 24.07.2023.
//

import Foundation
import SwiftUI


struct FabActionButton: View {
    
    var labelTitel: String
    var systemImage: String = "plus"
    
    var body: some View {
        Label(labelTitel, systemImage: systemImage)
            .padding(6)
            .font(.system(size: 18))
            .fontWeight(.bold)
            .background(.ultraThinMaterial, in: Capsule())
            .padding(.leading)
            .padding(.bottom)
            .symbolVariant(.circle.fill)
    }
}


#Preview {
    FabActionButton(labelTitel: "Create Test")
}
