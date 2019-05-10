//
//  Transaction.swift
//  Spearmint
//
//  Created by Brian Ishii on 4/24/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation


class Transaction: Codable {
    
    var id: TransactionID
    var name: String
    var transactionType: TransactionType
    var merchant: String
    var amount: Float
    var date: String
    var location: String
    var image: String
    var notes: String
    var budget: Budget
    var budgetItems: [Item]
    
    init(name: String, transactionType: TransactionType, merchant: String, amount: Float,
         date: String, location: String, image: String, notes: String, budget: Budget, budgetItems: [Item]) {
        self.id = TransactionID()
        self.name = name
        self.transactionType = transactionType
        self.merchant = merchant
        self.amount = amount
        self.date = date
        self.location = location
        self.image = image
        self.notes = notes
        self.budget = budget
        self.budgetItems = budgetItems
    }
    
    static let dummyTransaction =
        Transaction(name: "test1", transactionType: TransactionType.income, merchant: "Apple", amount: 10.00, date: TransactionDate.getCurrentDate(), location: "N/A", image: "N/A", notes: "notes", budget: Budget(name: "budgetName", date: "date", items: []), budgetItems: [])
    
}
