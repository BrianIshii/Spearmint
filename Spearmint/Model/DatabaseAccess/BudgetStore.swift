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

    public static var budgetDictionary: [String : Budget] = getBudgetDictionary()
    
    public static var budgets: [Budget] = getBudgets()
        
    private static let budgetString = "budget"

    static let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let budgetURL = documentsDirectory.appendingPathComponent(budgetString)

    static func getBudget(_ key: String) -> Budget? {
        return budgetDictionary[key]
    }
    
    static func addBudget(_ budget: Budget) {
        if budgetDictionary[budget.dateString] != nil {
            print("already have budget")
        } else {
            budgetDictionary[budget.dateString] = budget
        }
        update()
    }
    
    static func deleteBudget(_ budget: Budget) {
        budgetDictionary.removeValue(forKey: budget.dateString)
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
            BudgetStore.addBudget(Budget(date: transaction.budgetDate, items: BudgetItem.defaultBudgetItems()))
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
    
    private static func getBudgetDictionary() -> [String: Budget] {
        var budgets: [String: Budget]
        
        if LocalAccess.reset {
            let currentBudget = Budget(date: Budget.dateToString(Date()), items: BudgetItem.defaultBudgetItems())
            update(data: [currentBudget.dateString : currentBudget], url: budgetURL)
            return [currentBudget.dateString : currentBudget]
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
        return [currentBudget.dateString : currentBudget]
    }
    
    static func update() {
        update(data: budgetDictionary, url: budgetURL)
    }
    
    fileprivate static func update(data: [String : Budget], url: URL) {
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(data)
            try jsonData.write(to: url)
        } catch {
            print(error)
        }
        
        budgetViewControllerNeedsUpdate = true
        SummaryViewControllerNeedsUpdate = true
    }
}
