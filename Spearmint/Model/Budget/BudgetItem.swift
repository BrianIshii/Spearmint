//
//  BudgetItem.swift
//  Spearmint
//
//  Created by Brian Ishii on 4/24/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

class BudgetItem: Codable, Hashable {
    var id: BudgetItemID
    var name: String
    var category: BudgetItemCategory
    var planned: Float
    var actual: Float
    private var transactions: [TransactionID]
    
    init(name: String, category: BudgetItemCategory, planned: Float) {
        self.id = BudgetItemID()
        self.name = name
        self.category = category
        self.planned = planned
        self.actual = 0
        self.transactions = [TransactionID]()
    }
    
    init(name: String, category: BudgetItemCategory) {
        self.id = BudgetItemID()
        self.name = name
        self.category = category
        self.planned = 100
        self.actual = 0
        self.transactions = [TransactionID]()
    }
    
    func addTransaction(_ transaction: Transaction) {
        transactions.append(transaction.id)
        for item in transaction.items {
            if item.budgetItemName == name {
                actual += item.amount
            }
        }
    }
    
    func deleteTransaction(_ transaction: Transaction) {
        transactions.removeAll(where: { (t) -> Bool in
            return t == transaction.id
        })
        
        for item in transaction.items {
            if item.budgetItemName == name {
                actual -= item.amount
            }
        }
    }
    
    func mostExpensiveItem() -> Item? {
        var expensiveItem: Item?
        for id in transactions {
            if let transaction = TransactionStore.getTransaction(id) {
                if let item = transaction.mostExpensiveItem(self) {
                    if let currentExpensiveItem = expensiveItem{
                        if currentExpensiveItem.amount < item.amount {
                            expensiveItem = item
                        }
                    } else {
                        expensiveItem = item
                    }
                }
            }
        }
        
        return expensiveItem
    }
    
    static func defaultBudgetItems() -> [BudgetItemCategory:[BudgetItem]] {
        return [BudgetItemCategory.income : [
                    BudgetItem(name: "Paycheck 1", category: BudgetItemCategory.income, planned: 1000)],
                BudgetItemCategory.housing : [
                    BudgetItem(name: "Mortgage/Rent", category: BudgetItemCategory.housing),
                    BudgetItem(name: "Water", category: BudgetItemCategory.housing),
                    BudgetItem(name: "Natural Gas", category: BudgetItemCategory.housing),
                    BudgetItem(name: "Electricity", category: BudgetItemCategory.housing),
                    BudgetItem(name: "Cable", category: BudgetItemCategory.housing),
                    BudgetItem(name: "Internet", category: BudgetItemCategory.housing),
                    BudgetItem(name: "Trash", category: BudgetItemCategory.housing)],
                BudgetItemCategory.transportation : [
                    BudgetItem(name: "Gas", category: BudgetItemCategory.transportation),
                    BudgetItem(name: "Maintenance", category: BudgetItemCategory.transportation)],
                BudgetItemCategory.giving : [],
                BudgetItemCategory.savings : [],
                BudgetItemCategory.food : [],
                BudgetItemCategory.personal : [],
                BudgetItemCategory.lifestyle : [],
                BudgetItemCategory.health : [],
                BudgetItemCategory.insurance : [],
                BudgetItemCategory.debt : [],
                BudgetItemCategory.other : []]
    }
    
    static func == (lhs: BudgetItem, rhs: BudgetItem) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id.description())
        hasher.combine(name)
        hasher.combine(category)
    }
}
