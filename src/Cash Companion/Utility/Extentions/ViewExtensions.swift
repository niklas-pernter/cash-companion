//
//  ViewExtensions.swift
//  Cash Companion
//
//  Created by Niklas Pernter on 26.07.2023.
//

import Foundation
import SwiftUI


extension View {
    
    func asNavigationView(title: String?) -> some View {
        NavigationStack { self }.navigationTitle(title ?? "")
    }
    
    func visible(_ shouldShow: Bool) -> some View {
        Group {
            if shouldShow {
                self
            } else {
                EmptyView()
            }
        }
    }
}

