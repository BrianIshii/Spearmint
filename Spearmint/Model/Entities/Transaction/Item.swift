//
//  Item.swift
//  Spearmint
//
//  Created by Brian Ishii on 4/24/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

class Item: Codable {
    var name: String
    var amount: Float
    var budgetItemName: String
    var budgetItemCategory: BudgetItemCategory
    
    init(name: String, amount: Float, budgetItem: String, budgetItemCategory: BudgetItemCategory) {
        self.name = name
        self.amount = amount
        self.budgetItemName = budgetItem
        self.budgetItemCategory = budgetItemCategory
    }
}
