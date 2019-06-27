//
//  BudgetLocalAccess.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/10/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

class BudgetStore {
    public static var budgetViewControllerNeedsUpdate = false
    public static var SummaryViewControllerNeedsUpdate = false

    public static var budgetDictionary: [BudgetDate : Budget] = getBudgetDictionary()
    
    public static var budgets: [Budget] = getBudgets()
        
    private static let budgetString = "budget"

    static let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let budgetURL = documentsDirectory.appendingPathComponent(budgetString)

    static func getBudget(_ key: BudgetDate) -> Budget? {
        return budgetDictionary[key]
    }
    
    static func addBudget(_ budget: Budget) {
        if budgetDictionary[budget.id] != nil {
            print("already have budget")
        } else {
            budgetDictionary[budget.id] = budget
        }
        update()
    }
    
    static func deleteBudget(_ budget: Budget) {
        budgetDictionary.removeValue(forKey: budget.id)
        update()
    }
    
    static func addTransaction(_ transaction: Transaction) {
        if let budget = budgetDictionary[transaction.budgetDate] {
            budget.transactions.append(transaction.id)
            
            for (_,v) in transaction.items {
                if let category = budget.items[v[0].budgetItemCategory] {
                    for i in category {
                        if i.name == v[0].budgetItemName {
                            for item in v {
                                    i.addTransactionItem(transaction, item)
                            }
                            break
                        }
                    }
                }
                
            }
        } else {
            BudgetStore.addBudget(Budget(transaction.budgetDate))
            BudgetStore.addTransaction(transaction)
        }
        update()
    }
    
    static func deleteTransaction(_ transaction: Transaction) {
        if let budget = budgetDictionary[transaction.budgetDate] {
            budget.transactions.removeAll(where: { (t) -> Bool in
                return t == transaction.id
                })
            
            for (_,v) in transaction.items {
                if let categoryItems = budget.items[v[0].budgetItemCategory] {
                    for i in categoryItems {
                        if i.name == v[0].budgetItemName {
                            for item in v {
                                i.deleteTransactionItem(transaction, item)
                            }
                            break
                        }
                    }
                }
            }
        }
        update()
    }
    
    private static func getBudgets() -> [Budget] {
        var budgets: [Budget] = []
        
        for (_, v) in budgetDictionary {
            budgets.append(v)
        }
        
        return budgets.sorted(by: <)
    }
    
    private static func getBudgetDictionary() -> [BudgetDate: Budget] {
        
        if LocalAccess.reset {
            let currentBudget = Budget(date: Budget.dateToString(Date()), items: LocalAccess.budgetItemStore.getBudgetItems())
            update(data: [currentBudget.id : currentBudget])
            return [currentBudget.id : currentBudget]
        }
        
        let temp = LocalAccess.getDictionary(key: BudgetDate.self, object: Budget.self)
        if temp.count == 0 {
            let currentBudget = Budget(BudgetDate())
            return [currentBudget.id : currentBudget]
        } else {
            return temp
        }
    }
    
    static func update() {
        update(data: budgetDictionary)
    }
    
    fileprivate static func update(data: [BudgetDate : Budget]) {
        LocalAccess.updateDictionary(data: data)
        
        budgetViewControllerNeedsUpdate = true
        SummaryViewControllerNeedsUpdate = true
    }
}
