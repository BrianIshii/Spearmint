//
//  Vendor.swift
//  Spearmint
//
//  Created by Brian Ishii on 6/23/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation

class Vendor: Saveable {
    let vendorID: VendorID
    
    var name: String
    var budgetCategory: BudgetItemCategory?
    var budgetItemName: String?
    var transactionIDs: [TransactionID]
    
    init(name: String) {
        self.vendorID = VendorID()
        self.name = name
        self.transactionIDs = []
    }
    
    func addTransaction(_ transaction: Transaction) {
        transactionIDs.append(transaction.id)
    }
    
    var ID: String {
        return vendorID.id
    }
}
