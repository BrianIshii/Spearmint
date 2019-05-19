//
//  BudgetLocalAccess.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/10/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

class BudgetStore {
    public static var budgetDictionary: [String : Budget] = getBudgetDictionary()
    
    public static var budgets: [Budget] = getBudgets()
    
    private static let budgetString = "budget"
    static let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let budgetURL = documentsDirectory.appendingPathComponent(budgetString)
    
    static func getBudget(key: String) -> Budget {
        return budgetDictionary[key] ?? Budget.dummyBudget
    }
    
    static func addBudget(budget: Budget) {
        budgetDictionary[budget.date] = budget
        update()
    }
    
    static func deleteBudget(budget: Budget) {
        budgetDictionary.removeValue(forKey: budget.date)
        update()
    }
    
    private static func getBudgets() -> [Budget] {
        var budgets: [Budget] = []
        
        for (_,v) in budgetDictionary {
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
