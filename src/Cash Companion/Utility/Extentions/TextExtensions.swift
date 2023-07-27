//
//  TextExtensions.swift
//  Cash Companion
//
//  Created by Niklas Pernter on 26.07.2023.
//

import Foundation
import SwiftUI

extension Text {
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

