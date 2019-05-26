//
//  Budget.swift
//  Spearmint
//
//  Created by Brian Ishii on 4/24/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

class Budget: Codable {
    
    var date: String
    var transactions: [TransactionID]
    var items: [BudgetItemCategory:[BudgetItem]]
    
    init(date: String, items: [BudgetItemCategory:[BudgetItem]]) {
        self.date = date
        self.transactions = []
        self.items = items
    }
    
    func addBudgetItem(budgetItem: BudgetItem) {
        items[budgetItem.category]!.append(budgetItem)
        BudgetStore.update()
    }
    
    static let dummyBudget = Budget(date: DateFormatterFactory.mediumFormatter.string(from: Date()), items: BudgetItem.defaultBudgetItems())
    
    static func dateToString(_ date: Date) -> String {
        return DateFormatterFactory.yearAndMonthFormatter.string(from: date)
    }
    
    var totalIncome: Float {
        var total: Float = 0.0
        if let budgetItems = items[BudgetItemCategory.income] {
            for item in budgetItems {
                total += item.actual
            }
        }
        return Float(total)
    }
    
    var totalExpenses: [BudgetItemCategory: Float] {
        var expenses: [BudgetItemCategory: Float] = [:]
        
        for key in items.keys {
            if (key != BudgetItemCategory.income) {
                var total: Float = 0.0

                for item in items[key]! {
                    total += item.actual
                }
                
                expenses[key] = total
            }
        }

        return expenses
    }
    
    var month: String {
        return DateFormatterFactory.monthFormatter.string(from: DateFormatterFactory.yearAndMonthFormatter.date(from: date)!)
    }
    
    var year: String {
        return DateFormatterFactory.yearFormatter.string(from: DateFormatterFactory.yearAndMonthFormatter.date(from: date)!)
    }
}
