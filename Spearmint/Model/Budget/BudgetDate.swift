//
//  BudgetDate.swift
//  Spearmint
//
//  Created by Brian Ishii on 6/26/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

class BudgetDate: SaveableKey {
    fileprivate var dateString: String = ""
    
    init () {
        self.dateString = dateToString(Date())
    }
    init(_ date: Date) {
        self.dateString = dateToString(date)
    }
    
    init(_ date: String) {
        self.dateString = date
    }
    
    var date: Date {
        return DateFormatterFactory.yearAndMonthFormatter.date(from: dateString) ?? Date()
    }
    
    var month: String {
        return DateFormatterFactory.monthFormatter.string(from: date)
    }
    
    var year: String {
        return DateFormatterFactory.yearFormatter.string(from: date)
    }
    
    func dateToString(_ date: Date) -> String {
        return DateFormatterFactory.yearAndMonthFormatter.string(from: date)
    }
    
    static func < (lft: BudgetDate, rht: BudgetDate) -> Bool {
        return lft.dateString < rht.dateString
    }
    
    static func == (lhs: BudgetDate, rhs: BudgetDate) -> Bool {
        return lhs.dateString == rhs.dateString
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(dateString)
    }
}
