//
//  BudgetAccess.swift
//  Spearmint
//
//  Created by Brian Ishii on 8/5/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

protocol BudgetAccess {
    func getCurrentBudget() -> Budget
    func getAll() -> [Budget]
    func get(_ id: BudgetDate) -> Budget?
    func append(_ budget: Budget)
    func update(_ budget: Budget)
    func remove(_ budget: Budget)
}
