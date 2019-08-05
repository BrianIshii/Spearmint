//
//  Budget.swift
//  Spearmint
//
//  Created by Brian Ishii on 4/24/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

class Budget: Saveable {
    
    var budgetDate: BudgetDate
    var transactions: [TransactionID]
    var items: [BudgetItemCategory:[BudgetItemID]]
    
    init(date: BudgetDate, transactions: [TransactionID], items: [BudgetItemCategory:[BudgetItemID]]) {
        self.budgetDate = date
        self.transactions = transactions
        self.items = items
    }
    
    init(date: String) {
        self.budgetDate = BudgetDate(date)
        self.transactions = []
        self.items = LocalAccess.budgetItemStore.getBudgetItems()
    }
    
    init(date: String, items: [BudgetItemCategory:[BudgetItemID]]) {
        self.budgetDate = BudgetDate(date)
        self.transactions = []
        self.items = items
    }
    
    init(date: Date, items: [BudgetItemCategory:[BudgetItemID]]) {
        self.budgetDate = BudgetDate(date)
        self.transactions = []
        self.items = items
    }
    
    init(_ date: BudgetDate, items: [BudgetItemCategory:[BudgetItemID]]) {
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
        items[budgetItem.category]!.append(budgetItem.id)
        LocalAccess.Budgets.update()
    }
    
    static func dateToString(_ date: Date) -> String {
        return DateFormatterFactory.YearAndMonthFormatter.string(from: date)
    }
    
    var totalIncome: Float {
        var total: Float = 0.0
        if let budgetItems = items[BudgetItemCategory.income] {
            for id in budgetItems {
                if let budgetItem = LocalAccess.budgetItemStore.getBudgetItem(id){
                    total += budgetItem.actual
                }
            }
        }
        return Float(total)
    }
    
    var totalExpenses: [BudgetItemCategory: Float] {
        var expenses: [BudgetItemCategory: Float] = [:]
        
        for key in BudgetItemSectionStore.budgetItemSections {
            if (key.category != BudgetItemCategory.income) {
                var total: Float = 0.0

                for id in items[key.category]! {
                    if let item = LocalAccess.budgetItemStore.getBudgetItem(id) {
                        total += item.getMonthlyTotal(self.budgetDate)
                    }
                }
                
                expenses[key.category] = total
            }
        }

        return expenses
    }
    
    var mostExpensiveItemPerCategory: [BudgetItemCategory: Item] {
        let items: [BudgetItemCategory: Item] = [:]
        
        for key in BudgetItemSectionStore.budgetItemSections {
            let _: Item?
            if (key.category != BudgetItemCategory.income) {
//
//                for item in self.items[key.category]! {
//                    if let current = item.mostExpensiveItem() {
//                        mostExpensiveItem = current
//                    } else if let currentExpensiveItem = mostExpensiveItem, let current = item.mostExpensiveItem() {
//                        if currentExpensiveItem.amount < current.amount {
//                            mostExpensiveItem = current
//                        }
//                    }
//                }
                
//                if let temp = mostExpensiveItem {
//                    items[key.category] = temp
//                }
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
