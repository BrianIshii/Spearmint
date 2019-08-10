//
//  BudgetItemAccess.swift
//  Spearmint
//
//  Created by Brian Ishii on 8/6/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

protocol BudgetItemAccess {
    func getAllBudgetItems() -> [BudgetItem]
    func get(_ id: BudgetItemID) -> BudgetItem?
    func append(_ budgetItem: BudgetItem)
    func update(_ budgetItem: BudgetItem)
    func remove(_ budgetItem: BudgetItem)
}
