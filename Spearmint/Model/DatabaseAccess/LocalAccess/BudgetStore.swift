//
//  BudgetStore.swift
//  Spearmint
//
//  Created by Brian Ishii on 8/3/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

class BudgetStore: BaseRepo<Budget>, BudgetRepository {
    func getCurrentBudget() -> Budget {
        if let budget = get(BudgetDate()) {
            return budget
        } else {
            let budget = Budget(BudgetDate())
            append(budget)
            return budget
        }
    }
    
    func update(_ budget: Budget) {
        //
    }
    
    func remove(_ budget: Budget) {
        //
    }
    
}
