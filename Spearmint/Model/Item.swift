//
//  Item.swift
//  Spearmint
//
//  Created by Brian Ishii on 4/24/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

class Item {
    var name: String
    var amount: Float
    var budgetItem: BudgetItem
    
    init(name: String, amount: Float, budgetItem: BudgetItem) {
        self.name = name
        self.amount = amount
        self.budgetItem = budgetItem
    }
}
