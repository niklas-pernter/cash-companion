//
//  BudgetTests.swift
//  Cash CompanionTests
//
//  Created by Niklas Pernter on 24.07.2023.
//

import Foundation
import XCTest

@testable import Cash_Companion

class BudgetTests: XCTestCase {
    func testCalculateDailyBudget() {
        // Date formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")  // set time zone to UTC

        // Create a mock budget
        let startDate = dateFormatter.date(from: "2023/07/01")!
        let endDate = dateFormatter.date(from: "2023/07/31")!
        
        let amount = 3100.0
        let budget = Budget(startDate: startDate, endDate: endDate, amount: amount)

        let totalDays = Calendar.current.numberOfDaysBetween(budget.startDate, and: budget.endDate)
        // Iterate over each day
        for i in 1...totalDays {
            let customCurrentDate = startDate.addDays(days: i-1)
            let dailyBudget = budget.calculateDailyBudget(customCurrentDate: customCurrentDate)

            // Define expected value
            let expectedValue = Double(i) * (amount / Double(totalDays))
            
            // Check if the returned value is as expected
            XCTAssertEqual(dailyBudget, expectedValue, accuracy: 0.001)
        }
    }

    
}
