//
//  BudgetItem.swift
//  Spearmint
//
//  Created by Brian Ishii on 4/24/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

class BudgetItem {
    
    var name: String
    var planned: Float
    var actual: Float
    var transactions: [Transaction]
    var budget: Budget
    
    init(name: String, planned: Float, actual: Float, transactions: [Transaction], budget: Budget) {
        self.name = name
        self.planned = planned
        self.actual = actual
        self.transactions = transactions
        self.budget = budget
    }
}
