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
    
    public static var budgetDictionary: [String : Budget] = getBudgetDictionary()
    
    public static var budgets: [Budget] = getBudgets()
        
    private static let budgetString = "budget"

    static let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let budgetURL = documentsDirectory.appendingPathComponent(budgetString)

    static func getBudget(_ key: String) -> Budget {
        return budgetDictionary[key] ?? Budget.dummyBudget
    }
    
    static func addBudget(_ budget: Budget) {
        if budgetDictionary[budget.date] != nil {
            print("already have budget")
        } else {
            budgetDictionary[budget.date] = budget
        }
        update()
    }
    
    static func deleteBudget(_ budget: Budget) {
        budgetDictionary.removeValue(forKey: budget.date)
        update()
    }
    
    static func addTransaction(_ transaction: Transaction) {
        if let budget = budgetDictionary[transaction.budgetDate] {
            budget.transactions.append(transaction.id)
            
            for item in transaction.items {
                if let categoryItems = budget.items[item.budgetItemCategory] {
                    for i in categoryItems {
                        if i.id == item.budgetItem {
                            i.addTransaction(transaction)
                            break
                        }
                    }
                }
            }
        } else {
            budgetDictionary[transaction.budgetDate] = Budget(date: transaction.budgetDate, items: BudgetItem.defaultBudgetItems())
            addTransaction(transaction)
        }
        update()
    }
    
    static func deleteTransaction(_ transaction: Transaction) {
        if let budget = budgetDictionary[transaction.budgetDate] {
            budget.transactions.removeAll(where: { (t) -> Bool in
                return t == transaction.id
                })
            
            for item in transaction.items {
                if let categoryItems = budget.items[item.budgetItemCategory] {
                    for i in categoryItems {
                        if i.id == item.budgetItem {
                            i.deleteTransaction(transaction)
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
        
        return budgets
    }
    
    private static func getBudgetDictionary() -> [String: Budget] {
        var budgets: [String: Budget]
        
        if LocalAccess.reset {
            let currentBudget = Budget(date: Budget.dateToString(Date()), items: BudgetItem.defaultBudgetItems())
            update(data: [currentBudget.date : currentBudget], url: budgetURL)
            return [currentBudget.date : currentBudget]
        }
        
        do {
            let data = try Data(contentsOf: budgetURL)
            let decoder = JSONDecoder()
            let tempArr = try decoder.decode([String: Budget].self, from: data)
            budgets = tempArr
            
            return budgets
            
        } catch {
            print(error)
        }
        
        let currentBudget = Budget(date: Budget.dateToString(Date()), items: BudgetItem.defaultBudgetItems())
        return [currentBudget.date : currentBudget]
    }
    
    static func update() {
        update(data: budgetDictionary, url: budgetURL)
        budgetViewControllerNeedsUpdate = true
    }
    
    fileprivate static func update(data: [String : Budget], url: URL) {
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(data)
            try jsonData.write(to: url)
        } catch {
            print(error)
        }
    }
}
