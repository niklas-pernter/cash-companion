//
//  CustomPicker.swift
//  Cash Companion
//
//  Created by Niklas Pernter on 27.07.2023.
//

import SwiftUI

struct CustomPicker: View {
    @Binding var selectedAccountFrom: Account?
    @Binding var selectedAccountTo: Account?
    let accounts: [Account]

    var body: some View {
        GeometryReader { geometry in
            HStack {
                Picker(selection: $selectedAccountFrom, label: Text("Account from")) {
                    ForEach(accounts, id: \.self) { account in
                        Text(account.name).tag(account as Account?)
                    }
                }.pickerStyle(.wheel)
                .frame(maxWidth: geometry.size.width / 2)
                .clipped()

                Picker(selection: $selectedAccountTo, label: Text("Account To")) {
                    ForEach(accounts, id: \.self) { account in
                        Text(account.name).tag(account as Account?)
                    }
                }.pickerStyle(.wheel)
                .frame(maxWidth: geometry.size.width / 2)
                .clipped()
            }
        }
    }
}

