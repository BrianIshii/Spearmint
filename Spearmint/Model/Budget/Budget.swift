//
//  Budget.swift
//  Spearmint
//
//  Created by Brian Ishii on 4/24/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

class Budget: Saveable {
    
    private var budgetDate: BudgetDate
    var transactions: [TransactionID]
    var items: [BudgetItemCategory:[BudgetItem]]
    
    init(date: String, items: [BudgetItemCategory:[BudgetItem]]) {
        self.budgetDate = BudgetDate(date)
        self.transactions = []
        self.items = items
    }
    
    init(date: Date, items: [BudgetItemCategory:[BudgetItem]]) {
        self.budgetDate = BudgetDate(date)
        self.transactions = []
        self.items = items
    }
    
    init(_ date: BudgetDate, items: [BudgetItemCategory:[BudgetItem]]) {
        self.budgetDate = date
        self.items = items
        self.transactions = []
    }
    
    init(_ date: BudgetDate) {
        self.budgetDate = date
        self.items = LocalAccess.budgetItemStore.getBudgetItems()
        self.transactions = []
    }
    
    func addBudgetItem(budgetItem: BudgetItem) {
        items[budgetItem.category]!.append(budgetItem)
        BudgetStore.update()
    }
    
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
        
        for key in BudgetItemSectionStore.budgetItemSections {
            if (key.category != BudgetItemCategory.income) {
                var total: Float = 0.0

                for item in items[key.category]! {
                    total += item.actual
                }
                
                expenses[key.category] = total
            }
        }

        return expenses
    }
    
    var mostExpensiveItemPerCategory: [BudgetItemCategory: Item] {
        var items: [BudgetItemCategory: Item] = [:]
        
        for key in BudgetItemSectionStore.budgetItemSections {
            var mostExpensiveItem: Item?
            if (key.category != BudgetItemCategory.income) {
                
                for item in self.items[key.category]! {
                    if let current = item.mostExpensiveItem() {
                        mostExpensiveItem = current
                    } else if let currentExpensiveItem = mostExpensiveItem, let current = item.mostExpensiveItem() {
                        if currentExpensiveItem.amount < current.amount {
                            mostExpensiveItem = current
                        }
                    }
                }
                
                if let temp = mostExpensiveItem {
                    items[key.category] = temp
                }
            }
        }
        
        return items
    }
    
    static func < (lft: Budget, rht: Budget) -> Bool {
        return lft.budgetDate < rht.budgetDate
    }
    
    var date: Date {
        return budgetDate.date
    }
    
    var month: String {
        return budgetDate.month
    }
    
    var year: String {
        return budgetDate.year
    }
    
    public var id: BudgetDate {
        return budgetDate
    }
}
