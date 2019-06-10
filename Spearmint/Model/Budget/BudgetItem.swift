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
    
    func addTransactionItem(_ transaction: Transaction, _ item: Item) {
        if !transactions.contains(where: { $0.description() == transaction.id.description() }) {
            transactions.append(transaction.id)
        }
        
        if item.budgetItemName == name {
            actual += item.amount
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
    
    func deleteTransactionItem(_ transaction: Transaction, _ item: Item) {
        transactions.removeAll(where: { (t) -> Bool in
            return t == transaction.id
        })
        
        if item.budgetItemName == name {
            actual -= item.amount
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
                    BudgetItem(name: "Paycheck 1", category: BudgetItemCategory.income, planned: 6000)],
                BudgetItemCategory.housing : [
                    BudgetItem(name: "Mortgage/Rent", category: BudgetItemCategory.housing, planned: 2500),
                    BudgetItem(name: "Water", category: BudgetItemCategory.housing),
                    BudgetItem(name: "Natural Gas", category: BudgetItemCategory.housing),
                    BudgetItem(name: "Electricity", category: BudgetItemCategory.housing),
                    BudgetItem(name: "Cable", category: BudgetItemCategory.housing),
                    BudgetItem(name: "Internet", category: BudgetItemCategory.housing),
                    BudgetItem(name: "Trash", category: BudgetItemCategory.housing)],
                BudgetItemCategory.transportation : [
                    BudgetItem(name: "Gas", category: BudgetItemCategory.transportation, planned: 200),
                    BudgetItem(name: "Maintenance", category: BudgetItemCategory.transportation)],
                BudgetItemCategory.giving : [
                    BudgetItem(name: "Charity", category: BudgetItemCategory.giving)],
                BudgetItemCategory.savings : [
                    BudgetItem(name: "Retirement", category: BudgetItemCategory.savings, planned: 2000)],
                BudgetItemCategory.food : [
                    BudgetItem(name: "Groceries", category: BudgetItemCategory.food),
                     BudgetItem(name: "Eating Out", category: BudgetItemCategory.food)],
                BudgetItemCategory.personal : [
                    BudgetItem(name: "Personal Items", category: BudgetItemCategory.personal, planned: 250),
                    BudgetItem(name: "Subscriptions", category: BudgetItemCategory.personal)],
                BudgetItemCategory.lifestyle : [
                    BudgetItem(name: "Movies", category: BudgetItemCategory.lifestyle),
                    BudgetItem(name: "Outdoor Stuff", category: BudgetItemCategory.lifestyle)],
                BudgetItemCategory.health : [
                    BudgetItem(name: "Rock Climbing Gym", category: BudgetItemCategory.health)],
                BudgetItemCategory.insurance : [
                    BudgetItem(name: "Health Insurance", category: BudgetItemCategory.insurance),
                    BudgetItem(name: "Car Insurance", category: BudgetItemCategory.insurance)],
                BudgetItemCategory.debt : [
                    BudgetItem(name: "Credit Card", category: BudgetItemCategory.debt),
                    BudgetItem(name: "Student Loan", category: BudgetItemCategory.debt)],
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
