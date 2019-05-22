//
//  Transaction.swift
//  Spearmint
//
//  Created by Brian Ishii on 4/24/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation


class Transaction: Codable {
    
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
    var items: [Item]
    
    init(name: String, transactionType: TransactionType, merchant: String, amount: Float,
         date: String, location: String, image: Bool, notes: String, budgetID: String, items: [Item]) {
        self.id = TransactionID()
        self.name = name
        self.transactionType = transactionType
        self.paymentType = ""
        self.vendor = merchant
        self.amount = amount
        self.date = date
        self.location = location
        self.hasImage = image
        self.notes = notes
        self.budgetDate = budgetID
        self.items = items
    }
    
    static let dummyTransaction =
        Transaction(name: "test1", transactionType: TransactionType.income, merchant: "Apple", amount: 10.00, date: TransactionDate.getCurrentDate(), location: "N/A", image: false, notes: "notes", budgetID: Budget.dateToString(Date()), items: [])
 
    func isInCurrentMonth() -> Bool {
        let currentDate = Date()
        let transactionDate = DateFormatterFactory.mediumFormatter.date(from: date)!
        return currentDate.isInSameMonth(date: transactionDate) && currentDate.isInSameYear(date: transactionDate)
    }
    
    static func > (left: Transaction, right: Transaction) -> Bool {
        return DateFormatterFactory.mediumFormatter.date(from: left.date)! > DateFormatterFactory.mediumFormatter.date(from: right.date)!
    }
    
}
