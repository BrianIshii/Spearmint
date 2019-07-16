//
//  BudgetItem.swift
//  Spearmint
//
//  Created by Brian Ishii on 4/24/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

class BudgetItem: Saveable, Hashable {
    var id: BudgetItemID
    var name: String
    var category: BudgetItemCategory
    var planned: Float
    var actual: Float
    var isActive: Bool
    var transactions: [BudgetDate: [TransactionID]]
    
    init(name: String, category: BudgetItemCategory, planned: Float) {
        self.id = BudgetItemID()
        self.name = name
        self.category = category
        self.planned = planned
        self.actual = 0
        self.isActive = true
        self.transactions = [:]
    }
    
    init(name: String, category: BudgetItemCategory) {
        self.id = BudgetItemID()
        self.name = name
        self.category = category
        self.planned = 100
        self.actual = 0
        self.isActive = true
        self.transactions = [:]
    }
    
    func addTransaction(_ transaction: Transaction) {
        if var transactionIDs = transactions[transaction.budgetDate] {
            transactionIDs.append(transaction.id)
        } else {
            transactions[transaction.budgetDate] = [transaction.id]
        }
//        for (k, v) in transaction.items {
//            if k == name {
//                for item in v {
//                    actual += item.amount
//                }
//            }
//        }
    }
    
//    func addTransactionItem(_ transaction: Transaction, _ item: Item) {
//        if !transactions.contains(where: { $0.description() == transaction.id.description() }) {
//            transactions.append(transaction.id)
//        }
//
//        if item.budgetItemName == name {
//            actual += item.amount
//        }
//    }
    
    func deleteTransaction(_ transaction: Transaction) {
        if var transactionIDs = transactions[transaction.budgetDate] {
            for (index, id) in transactionIDs.enumerated() {
                if transaction.id == id {
                    transactionIDs.remove(at: index)
                    return
                }
            }
        }
//        transactions.removeAll(where: { (t) -> Bool in
//            return t == transaction.id
//        })
//
//        for (k, v) in transaction.items {
//            if k == name {
//                for item in v {
//                    actual -= item.amount
//                }
//            }
//        }
    }
    
//    func deleteTransactionItem(_ transaction: Transaction, _ item: Item) {
//        transactions.removeAll(where: { (t) -> Bool in
//            return t == transaction.id
//        })
//
//        if item.budgetItemName == name {
//            actual -= item.amount
//        }
//    }
    
//    func mostExpensiveItem() -> Item? {
//        var expensiveItem: Item?
//        for id in transactions {
//            if let transaction = TransactionStore.getTransaction(id) {
//                if let item = transaction.mostExpensiveItem(self) {
//                    if let currentExpensiveItem = expensiveItem{
//                        if currentExpensiveItem.amount < item.amount {
//                            expensiveItem = item
//                        }
//                    } else {
//                        expensiveItem = item
//                    }
//                }
//            }
//        }
//        
//        return expensiveItem
//    }
    
    var ID: String {
        return id.id
    }
    
    static func == (lhs: BudgetItem, rhs: BudgetItem) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id.id)
        hasher.combine(name)
        hasher.combine(category)
    }
}
