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
    
    init(_ date: BudgetDate, items: [BudgetItemCategory:[BudgetItemID]]) {
        self.budgetDate = date
        self.items = items
        self.transactions = []
    }
    
    init(_ date: BudgetDate) {
        self.budgetDate = date
        self.items = [:]
        self.transactions = []
    }
    
    func addBudgetItem(budgetItem: BudgetItem) {
        guard let budgetRepository = AppDelegate.container.resolve(BudgetRepository.self) else {
            print("failed to resolve \(BudgetRepository.self)")
            return
        }
        
        items[budgetItem.category]!.append(budgetItem.id)
        budgetRepository.update()
    }
    
    static func dateToString(_ date: Date) -> String {
        return DateFormatterFactory.YearAndMonthFormatter.string(from: date)
    }
    
    var totalIncome: Float {
        var total: Float = 0.0
        guard let budgetItemRepository = AppDelegate.container.resolve(BudgetItemRepository.self) else {
            print("failed to resolve \(BudgetItemRepository.self)")
            return 0.0
        }
        if let budgetItems = items[BudgetItemCategory.income] {
            for id in budgetItems {
                if let budgetItem = budgetItemRepository.get(id) {
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

                guard let budgetItemRepository = AppDelegate.container.resolve(BudgetItemRepository.self) else {
                    print("failed to resolve \(BudgetItemRepository.self)")
                    return [:]
                }
                
                if let items = items[key.category] {
                    for id in items {
                        if let item = budgetItemRepository.get(id) {
                            total += item.getMonthlyTotal(self.budgetDate)
                        }
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
