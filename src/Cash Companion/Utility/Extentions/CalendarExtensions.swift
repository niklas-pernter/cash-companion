//
//  CalendarExtensions.swift
//  Cash Companion
//
//  Created by Niklas Pernter on 26.07.2023.
//

import Foundation
import SwiftUI

extension Calendar {
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
        let fromDate = startOfDay(for: from)
        guard let toDate = self.date(bySettingHour: 23, minute: 59, second: 59, of: to) else {
            fatalError("Could not set the end of the day for date: \(to)")
        }
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate)
        
        return numberOfDays.day! + 1
    }
}
