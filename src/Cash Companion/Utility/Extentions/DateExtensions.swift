//
//  DateExtensions.swift
//  Cash Companion
//
//  Created by Niklas Pernter on 26.07.2023.
//

import Foundation
import SwiftUI

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("d MMMM yyyy")
        return dateFormatter.string(from: self)
    }
    
    func addDays(days: Int) -> Date {
        var dateComponent = DateComponents()
        dateComponent.day = days
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: self)!
        return futureDate
    }
}
