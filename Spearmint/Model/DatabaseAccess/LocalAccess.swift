//
//  LocalAccess.swift
//  Spearmint
//
//  Created by Brian Ishii on 5/18/19.
//  Copyright © 2019 Brian Ishii. All rights reserved.
//

import Foundation
class LocalAccess {
    public static let reset: Bool = false
    
    public static func deleteTransaction(_ transaction: Transaction) {
        TransactionStore.deleteTransaction(transaction)
        BudgetStore.deleteTransaction(transaction)
        ImageStore.deleteImage(transaction.id)
    }
    
    public static func addTransaction(_ transaction: Transaction) {
        TransactionStore.addTransaction(transaction)
        BudgetStore.addTransaction(transaction)
    }
}
