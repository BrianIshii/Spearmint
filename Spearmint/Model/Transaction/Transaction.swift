//
//  Transaction.swift
//  Spearmint
//
//  Created by Brian Ishii on 4/24/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

class Transaction: Saveable {
    
    let id: TransactionID
    var name: String
    var transactionType: TransactionType
    var paymentType: String
    var vendor: String
    var amount: Float
    var date: String
    var location: String
    var hasImage: Bool
    var notes: String
    var budgetDate: String
    var items: [String : [Item]]
    
    init(name: String, transactionType: TransactionType, vendor: String, amount: Float,
         date: String, location: String, image: Bool, notes: String, budgetID: String, items: [String : [Item]]) {
        self.id = TransactionID()
        self.name = name
        self.transactionType = transactionType
        self.paymentType = ""
        self.vendor = vendor
        self.amount = amount
        self.date = date
        self.location = location
        self.hasImage = image
        self.notes = notes
        self.budgetDate = budgetID
        self.items = items
    }
 
    func isInCurrentMonth() -> Bool {
        let currentDate = Date()
        let transactionDate = DateFormatterFactory.mediumFormatter.date(from: date)!
        return currentDate.isInSameMonth(date: transactionDate) && currentDate.isInSameYear(date: transactionDate)
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
    
    static func > (left: Transaction, right: Transaction) -> Bool {
        return DateFormatterFactory.mediumFormatter.date(from: left.date)! > DateFormatterFactory.mediumFormatter.date(from: right.date)!
    }
    
}
