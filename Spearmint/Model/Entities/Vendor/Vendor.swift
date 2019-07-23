//
//  Vendor.swift
//  Spearmint
//
//  Created by Brian Ishii on 6/23/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

class Vendor: Saveable {
    let id: VendorID
    
    var name: String
    var budgetCategory: BudgetItemCategory?
    var budgetItemID: BudgetItemID?
    var transactionIDs: [TransactionID]
    
    init(name: String) {
        self.id = VendorID()
        self.name = name
        self.transactionIDs = []
    }
    
    init(name: String, budgetCategory: BudgetItemCategory, budgetItemID: BudgetItemID) {
        self.id = VendorID()
        self.name = name
        self.budgetCategory = budgetCategory
        self.budgetItemID = budgetItemID
        self.transactionIDs = []
    }
    
    func addTransaction(_ transaction: Transaction) {
        transactionIDs.append(transaction.id)
    }
    
    var ID: String {
        return id.id
    }
}
