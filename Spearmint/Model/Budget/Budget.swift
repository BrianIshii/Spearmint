//
//  Budget.swift
//  Spearmint
//
//  Created by Brian Ishii on 4/24/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

class Budget: Codable {
    
    var date: String
    var transactions: [TransactionID]
    var items: [BudgetItemCategory:[BudgetItem]]
    
    init(date: String, items: [BudgetItemCategory:[BudgetItem]]) {
        self.date = date
        self.transactions = []
        self.items = items
    }
    
    func addTransaction(_ transaction: Transaction) {
        transactions.append(transaction.id)
        
        for item in transaction.items {
            if let categoryItems = items[item.budgetItemCategory] {
                for i in categoryItems {
                    if i.id == item.budgetItem {
                        i.addTransaction(transaction)
                        break
                    }
                }
            }
        }
        BudgetStore.update()
    }
    
    static let dummyBudget = Budget(date: DateFormatterFactory.mediumFormatter.string(from: Date()), items: BudgetItem.defaultBudgetItems())
    
    static func dateToString(_ date: Date) -> String {
        return DateFormatterFactory.yearAndMonthFormatter.string(from: date)
    }
    
    var month: String {
        return DateFormatterFactory.monthFormatter.string(from: DateFormatterFactory.yearAndMonthFormatter.date(from: date)!)
    }
    
    var year: String {
        return DateFormatterFactory.yearFormatter.string(from: DateFormatterFactory.yearAndMonthFormatter.date(from: date)!)
    }
}
