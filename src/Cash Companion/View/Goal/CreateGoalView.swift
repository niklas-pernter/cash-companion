

import SwiftUI
import SwiftData

struct CreateGoalView: View {
    

    @Environment(\.dismiss) private var dismiss


    @State private var amount: Double = 0.0
    
    var body: some View {
        
            List {
                
              
                
                
                
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Dismiss") {
                        dismiss()
                    }
                }
            }
            .navigationTitle("Create Goal").navigationBarTitleDisplayMode(.inline)
        
    }
}

#Preview {
    AccountsView()
}
