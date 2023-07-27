//
//  CustomNoContentView.swift
//  Cash Companion
//
//  Created by Niklas Pernter on 22.07.2023.
//

import SwiftUI

struct CustomNoContentView: View {
    @State var showSheet: Bool = false
        var imageName: String
        var message: String
        var buttonLabel: String?
        var buttonAction: (() -> Void)?
        var sheetContent: AnyView?

        var body: some View {
            HStack() {
                Spacer()
                VStack(spacing: 15){
                    Image(systemName: imageName).font(.system(size: 48)).fontWeight(.bold).foregroundColor(.gray)
                    Text(message).font(.title2).fontWeight(.bold).multilineTextAlignment(.center)
                    
                    if buttonLabel != nil {
                        Button(action: {
                            self.buttonAction?()
                            if self.sheetContent != nil {
                                self.showSheet = true
                            }
                        }) {
                            Text(buttonLabel!)
                            
                        }.buttonStyle(.borderedProminent)
                        .sheet(isPresented: $showSheet) {
                            self.sheetContent ?? AnyView(EmptyView())
                        }
                    }
                    

                }
                Spacer()
                
            }.padding()
        }
}

#Preview {
    CustomNoContentView(imageName: "dollarsign.circle", message: "")
}
