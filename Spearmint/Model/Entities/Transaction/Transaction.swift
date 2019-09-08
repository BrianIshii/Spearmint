//
//  Transaction.swift
//  Spearmint
//
//  Created by Brian Ishii on 4/24/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation
import CloudKit

class Transaction: Saveable {
    let id: TransactionID
    var name: String
    var transactionType: TransactionType
    var paymentType: String
    var vendor: VendorID
    var amount: Float
    var date: TransactionDate
    var location: String
    var hasImage: Bool
    var tags: [String]
    var notes: String
    var budgetDate: BudgetDate
    var items: [BudgetItemID : [Item]]
    
    init(id: TransactionID, name: String, transactionType: TransactionType, vendor: VendorID, amount: Float,
         date: TransactionDate, location: String, image: Bool, tags: [String], notes: String, budgetDate: BudgetDate, items: [BudgetItemID : [Item]]) {
        self.id = id
        self.name = name
        self.transactionType = transactionType
        self.paymentType = ""
        self.vendor = vendor
        self.amount = amount
        self.date = date
        self.location = location
        self.hasImage = image
        self.tags = tags
        self.notes = notes
        self.budgetDate = budgetDate
        self.items = items
    }
    
    init(name: String, transactionType: TransactionType, vendor: VendorID, amount: Float,
         date: TransactionDate, location: String, image: Bool, notes: String, budgetDate: BudgetDate, items: [BudgetItemID : [Item]]) {
        self.id = TransactionID()
        self.name = name
        self.transactionType = transactionType
        self.paymentType = ""
        self.vendor = vendor
        self.amount = amount
        self.date = date
        self.location = location
        self.hasImage = image
        self.tags = []
        self.notes = notes
        self.budgetDate = budgetDate
        self.items = items
    }
    
    init(name: String, transactionType: TransactionType, vendor: VendorID, amount: Float,
         date: TransactionDate, location: String, image: Bool, tags: [String], notes: String, budgetDate: BudgetDate, items: [BudgetItemID : [Item]]) {
        self.id = TransactionID()
        self.name = name
        self.transactionType = transactionType
        self.paymentType = ""
        self.vendor = vendor
        self.amount = amount
        self.date = date
        self.location = location
        self.hasImage = image
        self.tags = tags
        self.notes = notes
        self.budgetDate = budgetDate
        self.items = items
    }
    
    func mostExpensiveItem(_ budgetItem: BudgetItem) -> Item? {
        var expensiveItem: Item?
        for (_, v) in items {
            for item in v {
                if item.budgetItemName == budgetItem.name
                    && item.budgetItemCategory == budgetItem.category {
                    if let currentExpensiveItem = expensiveItem {
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
    
    var ID: String {
        return id.id
    }
    
    static func > (left: Transaction, right: Transaction) -> Bool {
        return left.date > right.date
    }
}
