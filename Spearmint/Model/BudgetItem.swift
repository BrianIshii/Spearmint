//
//  BudgetItem.swift
//  Spearmint
//
//  Created by Brian Ishii on 4/24/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

class BudgetItem: Codable {
    var id: BudgetItemID
    var name: String
    var category: BudgetItemCategory
    var planned: Float
    var actual: Float
    var transactions: [TransactionID]
    
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
        self.planned = 0
        self.actual = 0
        self.transactions = [TransactionID]()
    }
    
    static func defaultBudgetItems() -> [BudgetItem] {
        return [BudgetItem(name: "Paycheck 1", category: BudgetItemCategory.income),
                BudgetItem(name: "Mortgage/Rent", category: BudgetItemCategory.housing),
                BudgetItem(name: "Water", category: BudgetItemCategory.housing),
                BudgetItem(name: "Natural Gas", category: BudgetItemCategory.housing),
                BudgetItem(name: "Electricity", category: BudgetItemCategory.housing),
                BudgetItem(name: "Cable", category: BudgetItemCategory.housing),
                BudgetItem(name: "Internet", category: BudgetItemCategory.housing),
                BudgetItem(name: "Trash", category: BudgetItemCategory.housing),
                BudgetItem(name: "Gas", category: BudgetItemCategory.transportation),
                BudgetItem(name: "Maintenance", category: BudgetItemCategory.transportation)]
    }
}
